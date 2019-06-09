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
    
    lazy var refreshingView: RefreshingView = {
        let temp = RefreshingView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    lazy var viewControllerImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    lazy var button: UIButton = {
        let temp = UIButton(type: UIButton.ButtonType.system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.setTitle("ObjcViewController", for: UIControl.State.normal)
        temp.addTarget(self, action: Selector.triggerObjcViewController, for: UIControl.Event.touchUpInside)
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerSettings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
        PermissionManager.shared.completionHandlerPermissionsAcquired = { (granted) -> Void in
            print("granted : \(granted)")
            
            LocationManager.shared.getCurrentPlaceMarkData(completion: { (placeMarks) in
                guard let placeMarkFirstItem = placeMarks.first else { return }
                guard let countryCode = placeMarkFirstItem.isoCountryCode else { return }
                print("placeMarks: \(placeMarks)")
                print("placeMarkFirstItem : \(placeMarkFirstItem)")
                print("countryCode : \(countryCode)")
                
                self.viewModel.getPresentedCountries(apiCallInputStruct: ApiCallInputStruct(callType: .presentedCountries, urlString: CONSTANT.CLOUD_FUNCTIONS_KEYS.URLS.presentedCountries), currentCountryCode: countryCode)
                
            })
            
        }

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
        viewModel.mapViewActivation.unbind()
    }
    
}

// MARK: - major funtions
extension MainViewController {
    
    private func prepareViewControllerSettings() {
        //addButton()
        configureViewControllerSettings()
        addViews()
        addMainBackgroundImage()
        addListeners()
        
    }
    
    private func configureViewControllerSettings() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    private func addButton() {
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            ])
    }
    
    @objc fileprivate func triggerObjcViewController(_ sender: UIButton) {
        let objcViewController = MapViewController()
        let navigationViewController = UINavigationController(rootViewController: objcViewController)
        self.present(navigationViewController, animated: true, completion: nil)
        
    }
    
    private func addViews() {
        self.view.addSubview(viewControllerImage)
        NSLayoutConstraint.activate([
            viewControllerImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewControllerImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewControllerImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewControllerImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            ])
        
        self.addBottomSheetViews()
        self.addRefreshingView()
        
    }
    
    private func addRefreshingView() {
        self.view.addSubview(refreshingView)
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
                self.presentWarningViewController()
            }
        }
        
        viewModel.feedDataToCountySelectionView.bind { (countryListData) in
            self.countrySelectionView.setPresentedCountriesData(data: countryListData)
        }
        
        viewModel.mapViewActivation.bind { (activation) in
            self.mapView.activationManager(active: activation)
        }
        
        self.listenCountrySelectionViewDataChanges()
        
    }
    
    private func presentWarningViewController() {
        let warningViewContoller = WarningViewController()
        warningViewContoller.delegate = self
        warningViewContoller.modalPresentationStyle = .overCurrentContext
        warningViewContoller.modalTransitionStyle = .crossDissolve
        self.present(warningViewContoller, animated: true, completion: nil)
//        self.navigationController?.pushViewController(warningViewContoller, animated: true)
        
    }
    
    private func addBottomSheetViews() {
        let mainScreenBounds = UIScreen.main.bounds
        
        mapView = MapView(frame: CGRect(origin: CGPoint(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding()), size: mainScreenBounds.size))
        
        countrySelectionView = CountrySelectionView(frame: CGRect(origin: CGPoint(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding()), size: CGSize(width: mainScreenBounds.width, height: CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE_ACTIVE)))
        countrySelectionView.delegate = self
        
        self.view.addSubview(countrySelectionView)
        self.view.addSubview(mapView)

    }

    private func listenCountrySelectionViewDataChanges() {
        self.countrySelectionView.listenSelectedCountryData { (selectedCountryData) in
            
            if let country = selectedCountryData.country {
                print("selected country data : \(country.countryName)")
            } else {
                print("country is nil")
            }
            
            if let city = selectedCountryData.city {
                print("selected city data : \(city)")
            } else {
                print("city is nil")
            }
            
            
            
            
        }
    }
    
}

// MARK: - ViewAnimationTrigger
extension MainViewController: ViewAnimationTrigger {
    func triggerAnimation(direction: Direction?) {
        print("\(#function)")
        guard let direction = direction else { return }
        print("direction: \(direction)")
        mapView.animatedFromOutside(direction: direction)
    }
}

fileprivate extension Selector {
    static let triggerObjcViewController = #selector(MainViewController.triggerObjcViewController)
}

extension MKMapView {
    var northWestCoordinate: CLLocationCoordinate2D {
        print("northWestCoordinate : \(MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate)")
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate
    }
    
    var northEastCoordinate: CLLocationCoordinate2D {
        print("northEastCoordinate : \(MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate)")
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate
    }
    
    var southEastCoordinate: CLLocationCoordinate2D {
        print("southEastCoordinate : \(MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate)")
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate
    }
    
    var southWestCoordinate: CLLocationCoordinate2D {
        print("southWestCoordinate : \(MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate)")
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate
    }
}
