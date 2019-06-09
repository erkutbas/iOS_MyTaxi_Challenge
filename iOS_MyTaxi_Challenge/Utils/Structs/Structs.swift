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
    
    init(callType: ApiCallType, urlString: String) {
        self.callType = callType
        self.urlString = urlString
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


