//
//  PermissionViewController.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class PermissionViewController: PermissionTemplateViewController {
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        
        changeBackgroundcolor()
        addGestureToPermissionButton()
        setPermissionViewPrompts()
        setPermissionViewImages()
        
    }
    
    override func addGestureToPermissionButton() {
        self.configureGestureToPermissionButton()
    }
    
}

// MARK: - major functions
extension PermissionViewController {
    
    fileprivate func changeBackgroundcolor() {
        //self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureGestureToPermissionButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.pressedLocationButton)
        tapGesture.delegate = self
        self.locationPermissionButton.addGestureRecognizer(tapGesture)
    }
    
    private func setPermissionViewPrompts() {
        DispatchQueue.main.async {
            self.mainSubject.text = LocalizedConstants.PermissionPrompts.mainSubject
            self.detailedInformation.text = LocalizedConstants.PermissionPrompts.detailedInformation
        }
    }
    
    private func setPermissionViewImages() {
        if let backgroundImage = UIImage(named: "blurredTaxi.png") {
            self.imageView.image = backgroundImage
        }
        
        if let centerTopImage = UIImage(named: "taxiSample.jpg") {
            self.centerViewTopImage.image = centerTopImage
        }
        
        if let iconImage = UIImage(named: "location.jpg") {
            self.iconImageView.image = iconImage
        }
        
    }
    
    private func startAnimationCommon(inputObject: UIView) {
        
        inputObject.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // buton view kucultulur
        
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
extension PermissionViewController: UIGestureRecognizerDelegate {
    
    @objc fileprivate func pressLocatinButtonView(_ sender: UITapGestureRecognizer) {
        startAnimationCommon(inputObject: locationPermissionButton)
        
        PermissionManager.shared.requestPermission(permissionType: .location, permissionResult: locationPermissionButton.getPermissionResult())
        
        PermissionManager.shared.completionHandlerForLocationAuthorizationDidChange = { (updatedPermissionButtonProperty) -> Void in
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.locationPermissionButton.updateButtonView(permissionButtonProperty: updatedPermissionButtonProperty)
                }, completion: { (finish) in
                    if PermissionManager.shared.checkRequiredPermissionsExist() {
                        self.modalTransitionStyle = .crossDissolve
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                
            }
            
        }
        
    }
    
}

fileprivate extension Selector {
    static let pressedLocationButton = #selector(PermissionViewController.pressLocatinButtonView)
}
