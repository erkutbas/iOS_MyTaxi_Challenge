//
//  MapView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapView: BaseBottomSheetView {
    
    private var mapViewModel = MapViewModel()
    
    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        temp.setUserTrackingMode(.followWithHeading, animated: true)
        temp.isHidden = true
        
        temp.delegate = self
        temp.register(VehicleAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleAnnotationView.identifier)
        
        return temp
    }()
    
    lazy var refreshingView: RefreshingView = {
        let temp = RefreshingView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    // blur view
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let temp = UIVisualEffectView(effect: effect)
        temp.isUserInteractionEnabled = false
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.masksToBounds = true
        temp.isHidden = true
        return temp
    }()
    
    lazy var taxiCount: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.contentMode = .center
        temp.text = "0"
        temp.font = UIFont(name: "Avenir-Medium", size: 30)
        temp.textColor = #colorLiteral(red: 0.2392156863, green: 0.2588235294, blue: 0.3333333333, alpha: 1)
        
        return temp
    }()
    
    private var direction = Direction.up
    
    var mainScreenBounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        configureViewSettings()
    }
    
    deinit {
        mapViewModel.apiCallStatus.unbind()
        mapViewModel.mapTrigger.unbind()
    }

}

// MARK: - major functions
extension MapView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1)
        self.reArrangeViewTitles()
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        self.addMap()
        self.reArrangeTopBarViewConstraint()
        self.addBlurEffect()
        self.activationManager(active: false)
        self.addListener()
        self.addCountLabel()
        self.addRefreshingView()
    }
    
    private func reArrangeTopBarViewConstraint() {
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalToConstant: 100 + UIApplication.shared.returnBottomPadding()),
            ])
    }
    
    private func reArrangeViewTitles() {
        self.mainSubject.text = LocalizedConstants.TitlePrompts.mapViewScreen
        self.detailedInformation.text = LocalizedConstants.TitlePrompts.mapViewScreenDetail
    }
    
    private func addBlurEffect() {
        self.topBarView.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: self.topBarView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.topBarView.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: self.topBarView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.topBarView.bottomAnchor),
            ])
    }
    
    private func addMap() {
        self.addSubview(mapView)
        self.sendSubviewToBack(mapView)
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    private func addRefreshingView() {
        self.addSubview(refreshingView)
        NSLayoutConstraint.activate([
            
            refreshingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            refreshingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            refreshingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            refreshingView.topAnchor.constraint(equalTo: self.topAnchor),
            
            ])
        refreshingView.activationManager(active: false)
    }
    
    private func addCountLabel() {
        self.topBarView.addSubview(taxiCount)
        NSLayoutConstraint.activate([
            
            taxiCount.trailingAnchor.constraint(equalTo: self.topBarView.trailingAnchor, constant: -20),
            taxiCount.centerYAnchor.constraint(equalTo: self.topBarView.centerYAnchor),
            
            ])
        
    }
    
    private func mapViewHiddenManager(active: Bool) {
        self.mapView.isHidden = !active
    }
    
    private func addListener() {
        mapViewModel.mapTrigger.bind { (mapTrigger) in
            self.mapTriggerOperations(mapTrigger: mapTrigger)
        }
        
        mapViewModel.apiCallStatus.bind { (status) in
            self.manageApiCallProcess(status: status)
        }
    }
    
    private func mapTriggerOperations(mapTrigger: MapUpdateTrigger) {
        switch mapTrigger {
        case .outsider:
            self.activationManager(active: true)
            self.focusMapAndLoadAnnotations()
            
        case .insider:
            self.updateMapViewAnnotations()
            
        default:
            break
        }
        
        self.setTaxiCount()
    }
    
    private func focusMapAndLoadAnnotations() {
        print("\(#function)")
        
        DispatchQueue.main.async {
            self.addAnnotationsToMapView()
            self.mapView.setRegion(MKCoordinateRegion(center: self.mapViewModel.returnRegionCoordinate(), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
            
        }
    }
    
    private func updateMapViewAnnotations() {
        DispatchQueue.main.async {
            self.addAnnotationsToMapView()
        }
    }
    
    private func addAnnotationsToMapView() {
        self.removeAnnotationsOnMap()
        
        guard let data = self.mapViewModel.returnVehicleDataArray() else { return }
        
        for item in data {
            let annotation = VehiclePointAnnotation(data: item)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.location.coordinate.latitude, longitude: item.location.coordinate.longitude)
            
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    private func removeAnnotationsOnMap() {
        for annotation in self.mapView.annotations {
            if !(annotation is MKUserLocation) {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    private func setTaxiCount() {
        DispatchQueue.main.async {
            UIView.transition(with: self.taxiCount, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.taxiCount.text = String(describing: self.mapViewModel.returnTotalNumberOfTaxi())
            }, completion: nil)
        }
    }
    
    private func manageApiCallProcess(status: ApiCallStatus) {
        
        switch status {
        case .process:
            print("REFRESH BASLAR")
            self.refreshingView.activationManager(active: true)
        case .done:
            print("REFRESH BITIR")
            self.refreshingView.activationManager(active: false)
        default:
            break
        }
    }
    
    private func activationManager(active: Bool) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = active
        }
    }
    
    // outsider functions
    func setVehicleDataIntoMap(data: MapViewRequiredParams) {
        self.mapViewModel.getDataIntoViewModel(data: data)
    }
    
}

extension MapView: UIGestureRecognizerDelegate {
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGesture.delegate = self
        self.topBarView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        
        blurViewAnimations()
        mapKitAnimations()
        mainViewAnimations()
        
    }
    
    fileprivate func blurViewAnimations() {
        UIView.transition(with: self.blurView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            switch self.direction {
            case .down:
                self.blurView.isHidden = true
            case .up:
                self.blurView.isHidden = false
            default:
                break
            }
        })
    }
    
    fileprivate func mapKitAnimations() {
        UIView.transition(with: self.mapView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            switch self.direction {
            case .down:
                self.mapView.isHidden = true
            case .up:
                self.mapView.isHidden = false
            default:
                break
            }
        })
    }
    
    fileprivate func mainViewAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch self.direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = .identity
                //self.blurView.isHidden = true
                self.changeTitleTintColor(active: false)
                
            case .up:
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.direction = .down
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = CGAffineTransform(scaleX: 1, y: -1)
                //self.blurView.isHidden = false
                self.changeTitleTintColor(active: true)
                
            default:
                break
            }
            
        }, completion: nil)
    }
    
    private func changeTitleTintColor(active: Bool) {
        if active {
            self.mainSubject.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.detailedInformation.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.directionIcon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.mainSubject.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.detailedInformation.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.directionIcon.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    // outsider function
    func animatedFromOutside(direction: Direction) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height, width: self.frame.width, height: self.frame.height)
                //self.direction = .up
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
            case .up:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                //self.direction = .down
                self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
                
            default:
                break
            }
            
        }, completion: nil)
    }
    
}

// MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("\(#function)")
        
        print("NW : \(mapView.northWestCoordinate)")
        print("NE : \(mapView.northEastCoordinate)")
        print("SW : \(mapView.southWestCoordinate)")
        print("SE : \(mapView.southEastCoordinate)")
        
        mapViewModel.updateMapView(apiCallData: ApiCallInputStruct(callType: .listOfVehiclesCallByInsider, urlString: CONSTANT.MY_TAXI_URLS.URLS.RAW_URL_POI_SERVICE, p2Lat: String(describing: mapView.northWestCoordinate.latitude), p2Lon: String(describing: mapView.southEastCoordinate.longitude), p1Lat: String(describing: mapView.southEastCoordinate.latitude), p1Lon: String(describing: mapView.northWestCoordinate.longitude)))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: VehicleAnnotationView.identifier) as? VehicleAnnotationView else { return nil }
        
        //annotationView.delegate = self
        annotationView.frame.size.height = 30
        annotationView.frame.size.width = 30
        
        return annotationView
        
    }
    
}

fileprivate extension Selector {
    static let animateView = #selector(MapView.animateView)
}

