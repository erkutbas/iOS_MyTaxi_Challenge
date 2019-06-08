//
//  Constants.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

struct CONSTANT {
    struct MAP_KIT_CONSTANT {
        static var DISTANCE_FILTER_10 : Double = 10.0
        static var DISTANCE_FILTER_50 : Double = 50.0
        static var ZOOM_DEGREE_002 : Double = 0.02
        static var ZOOM_DEGREE_0_0025 : Double = 0.0025
        static var ZOOM_DEGREE_0_005 : Double = 0.005
        static var ZOOM_DEGREE_0_01 : Double = 0.01
        static var ZOOM_DEGREE_0_05 : Double = 0.05
        static var ZOOM_DEGREE_0_025 : Double = 0.025
        static var RADIUS_01 : Double = 0.10
    }
    
    struct OPEN_SKY_KEYS {
        struct URLS {
            static var stateAll : String = "https://Q2FTZTAy:fXUXaJ987hnSu8B@opensky-network.org/api/states/all?"
            static var updatedLocation : String = "https://Q2FTZTAy:fXUXaJ987hnSu8B@opensky-network.org/api/tracks/all?"
        }
    }
    
    struct CLOUD_FUNCTIONS_KEYS {
        struct URLS {
            static var presentedCountries : String = "https://us-central1-countrydatabasemanagement.cloudfunctions.net/CountryList"
        }
    }
    
    struct CHARS {
        static let SPACE = ""
    }
    
    struct NUMERICS {
        static let INT_ZERO: Int = 0
        static let FLOAT_ZERO: CGFloat = 0.0
        static let BOOL_FALSE: Bool = false
    }
    
    struct CACHE {
        static let DISK_PATH = "ios_chanllenge_myTaxi"
        static let MEMORY_CAPACITY = 1024 * 1024 * 20 // 20 MB
        static let DISK_CAPACITY = 1024 * 1024 * 100 // 100 MB
        static let EXPIRE_DAY = 15
    }
    
    struct VIEW_FRAME_VALUES {
        static let MAPVIEW_Y_COORDINATE: CGFloat = 100
        static let COUNTRY_SELECTION_VIEW_Y_COORDINATE: CGFloat = 200
        static let COUNTRY_SELECTION_VIEW_Y_COORDINATE_ACTIVE: CGFloat = 600
        static let MAPVIEW_Y_COORDINATE_ACTIVE: CGFloat = 0
    }
}
