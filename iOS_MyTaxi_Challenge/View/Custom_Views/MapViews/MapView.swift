//
//  MapView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapView: BaseBottomSheetView {
    
    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        temp.setUserTrackingMode(.followWithHeading, animated: true)
        
        temp.delegate = self
        temp.register(VehicleAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleAnnotationView.identifier)
        
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

}

// MARK: - major functions
extension MapView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1)
        self.reArrangeViewTitles()
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        self.reArrangeTopBarViewConstraint()
        self.activationManager(active: false)
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
    
    // outsider functions
    func activationManager(active: Bool) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = active
        }
    }
    
}

extension MapView: UIGestureRecognizerDelegate {
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGesture.delegate = self
        self.topBarView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch self.direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = .identity
                self.blurView.isHidden = true
                
            case .up:
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.direction = .down
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = CGAffineTransform(scaleX: 1, y: -1)
                self.blurView.isHidden = false
                
            default:
                break
            }
            
        }, completion: nil)
        
    }
    
    func animatedFromOutside(direction: Direction) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height, width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
            case .up:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .down
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
        //viewModel.getStatesData(openSkyNetworkRequestStruct: createOpenSkyNetworkRequestStruct(highestNorthCorner: mapView.northWestCoordinate, lowestSouthCorner: mapView.southEastCoordinate))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: VehicleAnnotationView.identifier) as? VehicleAnnotationView else { return nil }
        
        //annotationView.delegate = self
        //        annotationView.frame.size.height = 50
        //        annotationView.frame.size.width = 50
        
        return annotationView
        
    }
    
}

fileprivate extension Selector {
    static let animateView = #selector(MapView.animateView)
}

