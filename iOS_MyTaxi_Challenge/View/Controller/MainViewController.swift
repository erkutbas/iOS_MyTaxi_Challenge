//
//  MainViewController.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainViewController: UIViewController {
    
    private var viewModel = MainViewModel()
    
    private var mapView: MapView!
    private var countrySelectionView: CountrySelectionView!
    
    private var sideButtonView: SideButtonView!
    
    lazy var refreshingView: RefreshingView = {
        let temp = RefreshingView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        return temp
        
    }()
    
    lazy var viewControllerImage: CachedImageView = {
        let temp = CachedImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.contentMode = .scaleAspectFill
        temp.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1)
        return temp
    }()
    
    lazy var button: UIButton = {
        let temp = UIButton(type: UIButton.ButtonType.system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.setTitle("ObjcViewController", for: UIControl.State.normal)
        return temp
    }()
    
    lazy var stackViewForMainViewController: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [mainSubject, detailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 12
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let mainSubject: UILabel = {
        let temp = UILabel()
        temp.text = LocalizedConstants.TitlePrompts.mainWelcome
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.contentMode = .center
        temp.lineBreakMode = .byWordWrapping
        temp.font = UIFont(name: "Avenir-Heavy", size: 36)
        temp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return temp
    }()
    
    let detailedInformation: UILabel = {
        let temp = UILabel()
        temp.text = LocalizedConstants.TitlePrompts.detailWelcome
        temp.textColor = UIColor.lightGray
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.lineBreakMode = .byWordWrapping
        temp.font = UIFont(name: "Avenir-Medium", size: 20)
        temp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerSettings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialOperations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    deinit {
        viewModel.apiCallStatus.unbind()
        viewModel.unsuitableCountry.unbind()
        viewModel.feedDataToCountySelectionView.unbind()
        viewModel.backgroundImageChanger.unbind()
        viewModel.poiListApicallStatus.unbind()
        viewModel.sideButtonActivationListener.unbind()
        
    }
    
}

// MARK: - major funtions
extension MainViewController {
    
    private func prepareViewControllerSettings() {
        configureViewControllerSettings()
        addViews()
        addMainBackgroundImage()
        addListeners()
        
    }
    
    private func configureViewControllerSettings() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    private func initialOperations() {
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
        PermissionManager.shared.completionHandlerPermissionsAcquired = { (granted) -> Void in
            self.getNecessaryDataFromServers()
        }
        
    }
    
    private func getNecessaryDataFromServers() {
        LocationManager.shared.getCurrentPlaceMarkData(completion: { (result) in
            switch result {
            case .failure(let error):
                print("Error : \(error)")
            case .success(let placeMarks):
                guard let placeMarkFirstItem = placeMarks.first else { return }
                guard let countryCode = placeMarkFirstItem.isoCountryCode else { return }
                self.triggerGettingPresentedCountries(countryCode: countryCode)
                self.triggerGettingDefaultListOfVehicles()
            }
            
        })
    }
    
    private func triggerGettingPresentedCountries(countryCode: String) {
        // get presented countries by myTaxi in order to feed country selection bottom sheet views
        // and this process check users current country and it's availability for myTaxi
        self.viewModel.getPresentedCountries(apiCallInputStruct: ApiCallInputStruct(callType: .presentedCountries, urlString: CONSTANT.CLOUD_FUNCTIONS_KEYS.URLS.presentedCountries), currentCountryCode: countryCode)
    }
    
    private func triggerGettingDefaultListOfVehicles() {
        // get default challenge data (Germany, Hamburg)
        guard let latitude = CLLocationDegrees(exactly: CONSTANT.MY_TAXI_URLS.DEFAULT_HAMBURG_LOCATIONS.LATITUDE) else { return }
        guard let longitude = CLLocationDegrees(exactly: CONSTANT.MY_TAXI_URLS.DEFAULT_HAMBURG_LOCATIONS.LONGITUDE) else { return }
        self.viewModel.getListOfVehicles(apiCallStruct: ApiCallInputStruct(callType: .listOfVehiclesDefault, urlString: CONSTANT.MY_TAXI_URLS.URLS.DEFAULT_HAMBURG_SEARCH_URL, coordinate: CLLocation(latitude: latitude, longitude: longitude)))
    }
    
    private func addViews() {
        self.view.addSubview(viewControllerImage)
        self.view.addSubview(stackViewForMainViewController)
        
        NSLayoutConstraint.activate([
            viewControllerImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewControllerImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewControllerImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewControllerImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            stackViewForMainViewController.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackViewForMainViewController.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackViewForMainViewController.widthAnchor.constraint(equalToConstant: 300)
            
            ])
        
        self.addBottomSheetViews()
        self.addRefreshingView()
        
    }
    
    private func addRefreshingView() {
        self.view.addSubview(refreshingView)
        self.view.bringSubviewToFront(refreshingView)
        
        NSLayoutConstraint.activate([
            
            refreshingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            refreshingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            refreshingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            refreshingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            ])
    }
    
    private func addMainBackgroundImage() {
        guard let image = UIImage(named: "mainVC.jpg") else { return }
        self.viewControllerImage.image = image
    }
    
    private func addListeners() {
        viewModel.apiCallStatus.bind { (status) in
            switch status {
            case .process:
                self.refreshingView.activationManager(active: true)
            case .done:
                self.refreshingView.activationManager(active: false)
            default:
                break
            }
        }
        
        viewModel.unsuitableCountry.bind { (result) in
            if !result {
                self.presentWarningViewController(warningType: .countrySelection)
            }
        }
        
        viewModel.feedDataToCountySelectionView.bind { (countryListData) in
            self.countrySelectionView.setPresentedCountriesData(data: countryListData)
        }
        
        viewModel.backgroundImageChanger.bind { (urlString) in
            self.changeBackgroundImage(urlString: urlString)
        }
        
        viewModel.poiListApicallStatus.bind { (status) in
            self.mapViewManagers(status: status)
        }
        
        viewModel.sideButtonActivationListener.bind { (active) in
            self.sideButtonView.sideButtonActivationManager(active: active)
        }

        self.listenCountrySelectionViewDataChanges()
        
    }
    
    private func mapViewManagers(status: ApiCallStatus) {
        if status == .done {
            guard let data = self.viewModel.returnMapViewRequiredParams() else { return }
            self.mapView.setVehicleDataIntoMap(data: data)
        }
    }
    
    private func startGettingDataProcess(data: CountrySelectionStruct) {
        
    }
    
    private func changeBackgroundImage(urlString: String) {
        DispatchQueue.main.async {
            
            UIView.transition(with: self.viewControllerImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
                if urlString.isEmpty {
                    self.addMainBackgroundImage()
                } else {
                    self.viewControllerImage.loadImage(urlString: urlString)
                }
            }, completion: { (finish) in
                self.viewModel.setSideButtonActivationListenerValue(active: true)
            })
            
        }
    }
    
    private func presentWarningViewController(warningType: WarningType) {
        
        DispatchQueue.main.async {
            let warningViewContoller = WarningViewController()
            warningViewContoller.delegate = self
            warningViewContoller.modalPresentationStyle = .overCurrentContext
            warningViewContoller.modalTransitionStyle = .crossDissolve
            warningViewContoller.warningType = warningType
            
            self.present(warningViewContoller, animated: true, completion: nil)
        }
        
    }
    
    private func addBottomSheetViews() {
        let mainScreenBounds = UIScreen.main.bounds
        
        mapView = MapView(frame: CGRect(origin: CGPoint(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding()), size: mainScreenBounds.size))
        mapView.delegate = self
        
        countrySelectionView = CountrySelectionView(frame: CGRect(origin: CGPoint(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding()), size: CGSize(width: mainScreenBounds.width, height: CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE_ACTIVE)))
        countrySelectionView.delegate = self
        
        sideButtonView = SideButtonView(frame: CGRect(x: CONSTANT.VIEW_FRAME_VALUES.SIDE_BUTTON_FRAME_X, y: CONSTANT.VIEW_FRAME_VALUES.SIDE_BUTTON_FRAME_Y, width: CONSTANT.VIEW_FRAME_VALUES.SIDE_BUTTON_FRAME_WIDTH, height: 50))
        sideButtonView.delegate = self
        
        self.view.addSubview(countrySelectionView)
        self.view.addSubview(mapView)
        self.view.addSubview(sideButtonView)
        
    }
    
    private func listenCountrySelectionViewDataChanges() {
        self.countrySelectionView.listenSelectedCountryData { (selectedCountryData) in
            self.viewModel.changeBackgroundImage(data: selectedCountryData)

            LocationManager.shared.startGettingLocationDataByAddress(address: self.returnAddress(data: selectedCountryData), completion: { (result) in
                
                switch result {
                case .failure(let error):
                    print("Error : \(error)")
                case .success(let placeMarks):
                    guard let placeMarkFirstItem = placeMarks.first else { return }
                    let apiCallData = ApiCallInputStruct(callType: .listOfVehiclesCallByOutsider, urlString: CONSTANT.MY_TAXI_URLS.URLS.RAW_URL_POI_SERVICE, placeMark: placeMarkFirstItem)
                    self.viewModel.getListOfVehicles(apiCallStruct: apiCallData)
                }
            })
            
        }
    }
    
    private func returnAddress(data: CountrySelectionStruct) -> String {
        var address: String = CONSTANT.MY_TAXI_URLS.DEFAULT_CITY.HAMBURG
        
        if let country = data.country {
            address = country.countryName
        }
        
        if let city = data.city {
            address = address + " " + city
        }
        
        return address
    }
    
}

// MARK: - ViewAnimationTrigger
extension MainViewController: ViewAnimationTrigger {
    func triggerAnimation(direction: Direction?) {
        guard let direction = direction else { return }
        mapView.animatedFromOutside(direction: direction)
        
        self.sideButtonView.outsideAnimationManager()

    }
    
    func completeBottonSheetAnimation() {
        countrySelectionView.animatedFromOutside()
    }
    
    func sideButtonAnimationTrigger(direction: Direction) {
        self.sideButtonView.outsideAnimationManager()
        
    }

}

// MARK: - ViewControllerPresentationProtocol
extension MainViewController: ViewControllerPresentationProtocol {
    func pushViewController() {

        if self.viewModel.returnArrayDataForListView().count <= 0 {
            self.presentWarningViewController(warningType: .noVehicle)
        } else {
            let storyboard = UIStoryboard(name: "ListData", bundle: nil)
            let listDataViewController = storyboard.instantiateViewController(withIdentifier: "identifierTakasi") as! ListVehicleViewController
            
            guard let image = self.viewControllerImage.image else { return }
            
            listDataViewController.viewModel = ListDataViewModel(arrayData: self.viewModel.returnArrayDataForListView(), topImage: image, countryInformation: self.viewModel.returnSelectedContryData())
            self.present(listDataViewController, animated: true, completion: nil)
        }
        
    }
    
}

