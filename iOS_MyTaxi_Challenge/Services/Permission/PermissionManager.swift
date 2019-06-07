//
//  PermissionManager.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class PermissionManager: NSObject {
    
    public static var shared = PermissionManager()
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.delegate = self
    }
    
    var completionHandlerForLocationAuthorizationDidChange : ((PermissionButtonProperty) -> Void)?
    var completionHandlerPermissionsAcquired: ((Bool) -> Void)?
    
    /// Description : It's used to check the device has necessary permissions to move on
    ///
    /// - Parameter callerViewController: caller view controller to present permission view controller
    /// - Author: Erkut Bas
    func triggerPermissionCheck(callerViewController : UIViewController?) {
        
        if checkRequiredPermissionsExist() {
            // do nothing
        } else {
            let permissionViewController = PermissionViewController()
            permissionViewController.modalTransitionStyle = .crossDissolve
            guard let callerViewController = callerViewController else { return }
            callerViewController.present(permissionViewController, animated: true, completion: nil)
        }
        
    }
    
    /// Description : It's used to check required permissions exist or not
    ///
    /// - Returns: boolean value
    /// - Author: Erkut Bas
    func checkRequiredPermissionsExist() -> Bool {
        let locationAccessStatus = CLLocationManager.authorizationStatus()
        
        if locationAccessStatus != .authorizedWhenInUse {
            return false
        } else {
            return true
        }
    }
    
    /// Description : It's create a permission button view and returns
    ///
    /// - Parameter permissionType: permission type, location or camera
    /// - Returns: PermissionButtonView
    /// - Author: Erkut Bas
    func createPermissionButtonView(permissionType : PermissionType) -> PermissionButtonView {
        return PermissionButtonView(frame: CGRect(x: 0, y: 0, width: 240, height: 50), permissionButtonProperty: returnPermissionProperty(permissionType: permissionType))
    }
    
    
    /// Description: It creates permission styles
    ///
    /// - Parameter permissionType: location or camera
    /// - Returns: permission property struct
    /// - Author: Erkut Bas
    func returnPermissionProperty(permissionType: PermissionType) -> PermissionButtonProperty {
        var permissionButtonProperty = PermissionButtonProperty(image: UIImage(), backgroundColor: #colorLiteral(red: 0.2274509804, green: 0.8, blue: 0.8823529412, alpha: 1), backgroundColorOfIconContainer: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), buttonPrompt: "", permissionResult: .authorized)
        
        switch permissionType {
        case .location:
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                permissionButtonProperty.backgroundColor = #colorLiteral(red: 0.2607704401, green: 0.3113521636, blue: 0.3954211175, alpha: 1)
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationAccessed
                permissionButtonProperty.permissionResult = .authorized
                guard let image = UIImage(named: "tick.png") else { break }
                permissionButtonProperty.image = image
                break
            case .denied, .restricted:
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationEnable
                permissionButtonProperty.backgroundColorOfIconContainer = #colorLiteral(red: 0.9698399901, green: 0.4038827121, blue: 0.4230939746, alpha: 1)
                permissionButtonProperty.permissionResult = .denied
                guard let image = UIImage(named: "cross.png") else { break }
                permissionButtonProperty.image = image
                break
            case .notDetermined:
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationRequest
                permissionButtonProperty.permissionResult = .notDetermined
                guard let image = UIImage(named: "placeholder_location.png") else { break }
                permissionButtonProperty.image = image
                break
            @unknown default:
                fatalError()
            }
        }
        
        return permissionButtonProperty
    }
    
    /// Description: request location or camera access permission
    ///
    /// - Parameters:
    ///   - permissionType: location or camera
    ///   - permissionResult: common permissin result such as authorized, denied etc
    func requestPermission(permissionType : PermissionType, permissionResult: PermissionResult) {
        
        if permissionResult == .denied {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        } else {
            switch permissionType {
            case .location:
                guard let locationManager = locationManager else { return }
                locationManager.requestWhenInUseAuthorization()
            }
        }
        
    }
    
    
    /// Description: It's used to get current view controller in the foreground
    ///
    /// - Parameter rootViewController: ..
    /// - Returns: returns current view controller (toppest)
    /// - Author: Erkut Bas
    private func currentViewController(rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let presentedViewController = rootViewController?.presentedViewController {
            return currentViewController(rootViewController: presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return currentViewController(rootViewController: navigationController.visibleViewController)
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return currentViewController(rootViewController: selectedViewController)
            }
        }
        
        return rootViewController
    }
    
}

// MARK: - CLLocationManagerDelegate
extension PermissionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // because rigth after locationManager initialized, this method is triggered. That's why we do not check notDetermind status
        if status != .notDetermined {
            
            completionHandlerForLocationAuthorizationDidChange?(returnPermissionProperty(permissionType: .location))
            if checkRequiredPermissionsExist() {
                completionHandlerPermissionsAcquired?(true)
            }
        }
        
    }
    
}
