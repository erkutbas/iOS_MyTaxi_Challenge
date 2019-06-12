//
//  Enums.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

enum ApiCallExceptions: Error {
    case notEligibleUrl
    case httpStringFailed
}

enum PermissionManagerResult {
    case success
    case fail
}

enum PermissionResult {
    case notDetermined
    case denied
    case authorized
}

enum PermissionType {
    case location
}

enum BackendApiError: Error {
    case missingDataError
    case parseDataError
    case geoCoderFailed
}

enum ApiCallType {
    case presentedCountries
    case listOfVehiclesDefault
    case listOfVehiclesCallByOutsider
    case listOfVehiclesCallByInsider
}

enum ApiCallStatus {
    case process
    case done
    case failed
    case none
}

enum TimerControl {
    case start
    case stop
    case none
}

enum CollectionDataStatus {
    case loading
    case populate
    case none
}

enum Placement {
    case top
    case bottom
}

public enum ErrorType {
    case info
    case success
    case warning
    case error
}

enum Direction {
    case up
    case down
    case right
    case left
}

enum MapUpdateTrigger {
    case outsider
    case insider
    case none
}

enum VehicleState: String {
    case active = "active"
    case inActive = "inactive"
}

enum VehicleType {
    case taxi
}

enum WarningType {
    case countrySelection
    case noVehicle
}

enum AnimationCaller {
    case outsider
    case sideButton
}

public struct LoaderTransition {
    
    public enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        case `default`
        
        /// Return the media timing function associated with curve
        internal var function: CAMediaTimingFunction {
            let name: CAMediaTimingFunctionName!
            switch self {
            case .linear:
                name = CAMediaTimingFunctionName.linear
            case .easeIn:
                name = CAMediaTimingFunctionName.easeIn
            case .easeOut:
                name = CAMediaTimingFunctionName.easeOut
            case .easeInOut:
                name = CAMediaTimingFunctionName.easeInEaseOut
            case .default:
                name = CAMediaTimingFunctionName.default
            }
            
            return CAMediaTimingFunction(name: name)
        }
    }
    
    public enum Direction {
        case fade
        case toTop
        case toBottom
        case toLeft
        case toRight
        
        internal func transition() -> CATransition {
            let transition = CATransition()
            transition.type = CATransitionType.push
            switch self {
            case .fade:
                transition.type = CATransitionType.fade
                transition.subtype = nil
            case .toLeft:
                transition.subtype = CATransitionSubtype.fromLeft
            case .toRight:
                transition.subtype = CATransitionSubtype.fromRight
            case .toTop:
                transition.subtype = CATransitionSubtype.fromTop
            case .toBottom:
                transition.subtype = CATransitionSubtype.fromBottom
            }
            return transition
        }
    }
    
    /// Duration of the animation (default is 0.20s)
    public var duration: TimeInterval = 0.20
    
    /// Direction of the transition (default is `toRight`)
    public var direction: LoaderTransition.Direction = .toRight
    
    /// Style of the transition (default is `linear`)
    public var style: LoaderTransition.Curve = .linear
    
    /// Animation key
    public var forKey: String = kCATransition
    
    /// Initialize a new options object with given direction and curve
    ///
    /// - Parameters:
    ///   - direction: direction
    ///   - style: style
    public init(direction: LoaderTransition.Direction = .toRight, style: LoaderTransition.Curve = .linear, duration: CFTimeInterval = 0.5) {
        self.direction = direction
        self.style = style
        self.duration = duration
    }
    
    public init() { }
    
    /// Return the animation to perform for given options object
    internal var animation: CATransition {
        let transition = self.direction.transition()
        transition.duration = self.duration
        transition.timingFunction = self.style.function
        return transition
    }
}
