//
//  Structs.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct PermissionButtonProperty {
    var image: UIImage
    var backgroundColor: UIColor
    var backgroundColorOfIconContainer: UIColor
    var buttonPrompt: String
    var permissionResult: PermissionResult
}

struct ApiCallInputStruct {
    var callType: ApiCallType
    var urlString: String
    var placeMark: CLPlacemark?
    var coordinate: CLLocation?
    var p2Lat: String?
    var p2Lon: String?
    var p1Lat: String?
    var p1Lon: String?
    
    init(callType: ApiCallType, urlString: String, p2Lat: String, p2Lon: String, p1Lat: String, p1Lon: String) {
        self.callType = callType
        self.urlString = urlString
        self.p2Lat = p2Lat
        self.p2Lon = p2Lon
        self.p1Lat = p1Lat
        self.p1Lon = p1Lon
    }
    
    init(callType: ApiCallType, urlString: String) {
        self.callType = callType
        self.urlString = urlString
    }
    
    init(callType: ApiCallType, urlString: String, placeMark: CLPlacemark) {
        self.callType = callType
        self.urlString = urlString
        self.placeMark = placeMark
    }
    
    init(callType: ApiCallType, urlString: String, coordinate: CLLocation) {
        self.callType = callType
        self.urlString = urlString
        self.coordinate = coordinate
    }
}

struct CountrySelectionStruct {
    var country: CountryList?
    var city: String?
    
    /*
    init() {
        self.country = CountryList(countryImageURL: CONSTANT.CHARS.SPACE, cities: [], countryCode: CONSTANT.CHARS.SPACE, countryName: CONSTANT.CHARS.SPACE)
        self.city = CONSTANT.CHARS.SPACE
    }*/
    
    init() {}
    
    init(country: CountryList, city: String) {
        self.country = country
        self.city = city
    }
}

struct MapViewRequiredParams {
    var location: CLLocation
    var vehicleArray: Array<VehicleData>
    
    init(location: CLLocation, vehicleArray: Array<VehicleData>) {
        self.location = location
        self.vehicleArray = vehicleArray
    }
    
}

struct BottomAnimationsParams {
    var callerType: AnimationCaller
    var direction: Direction?
    
    init(callerType: AnimationCaller, direction: Direction?) {
        self.callerType = callerType
        self.direction = direction
    }
}
