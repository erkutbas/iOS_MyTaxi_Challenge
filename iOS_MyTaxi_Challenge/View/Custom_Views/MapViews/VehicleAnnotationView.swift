//
//  VehicleAnnotationView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class VehicleAnnotationView: MKAnnotationView {
    
//    weak var delegate: MapViewProtocols?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        prepareAnnotationViewConfigurations()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private func prepareAnnotationViewConfigurations() {
        
        self.canShowCallout = true
        
        setMarkerColor()
        addGestureRecognizer()
        
    }
    
    private func setMarkerColor() {
        let randomNumber = Int.random(in: 1 ..< 5)
        
        if randomNumber == 1 {
            self.image = UIImage(named: "taxi_1")
        } else if randomNumber == 2 {
            self.image = UIImage(named: "taxi_2")
        } else if randomNumber == 3 {
            self.image = UIImage(named: "taxi_3")
        } else if randomNumber == 4 {
            self.image = UIImage(named: "taxi_4")
        } else {
            self.image = UIImage(named: "taxi_1")
        }
    }
    
    private func startAnimationCommon(inputObject: UIView) {
        
        inputObject.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // buton view kucultulur
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.50),  // yay sonme orani, arttikca yanip sonme artar
            initialSpringVelocity: CGFloat(6.0),    // yay hizi, arttikca hizlanir
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                
                inputObject.transform = CGAffineTransform.identity
                
                
        })
        inputObject.layoutIfNeeded()
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension VehicleAnnotationView: UIGestureRecognizerDelegate {
    
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.annotationViewTapped)
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
    }
    
    @objc fileprivate func annotationViewTapped(_ sender: UITapGestureRecognizer) {
        self.startAnimationCommon()
        guard let annotation = self.annotation as? VehiclePointAnnotation else { return }
        guard let data = annotation.commonPlaceData else { return }
        
        // does not require to force unwrap. if it's nil, would not crash
        //delegate?.vehicleAnnotationSelected(data: data)
    }
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let annotationViewTapped = #selector(VehicleAnnotationView.annotationViewTapped)
}

