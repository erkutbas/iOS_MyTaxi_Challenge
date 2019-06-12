//
//  VehicleData.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import CoreLocation

class VehicleData: CommonPlaceData {
    
    var id: Int
    var location: CLLocation
    var state: VehicleState
    var type: VehicleType
    var heading: CGFloat
    
    init() {
        id = CONSTANT.NUMERICS.INT_ZERO
        location = CLLocation()
        state = VehicleState.inActive
        type = VehicleType.taxi
        heading = CONSTANT.NUMERICS.FLOAT_ZERO
    }
    
    init(data: PoiList) {
        
        if let id = data.id {
            self.id = id
        } else {
            self.id = CONSTANT.NUMERICS.INT_ZERO
        }
        
        if let coordinate = data.coordinate {
            if let latitude = coordinate.latitude, let longitude = coordinate.longitude {
                self.location = CLLocation(latitude: latitude, longitude: longitude)
            } else {
                self.location = CLLocation()
            }
        } else {
            self.location = CLLocation()
        }
        
        if let state = data.state {
            switch state {
            case .active:
                self.state = VehicleState.active
            case .inActive:
                self.state = VehicleState.inActive
            }
        } else {
            self.state = VehicleState.inActive
        }
        
        if let type = data.type {
            switch type {
            case .taxi:
                self.type = VehicleType.taxi
            }
        } else {
            self.type = VehicleType.taxi
        }
        
        if let heading = data.heading {
            self.heading = CGFloat(heading)
        } else {
            self.heading = CONSTANT.NUMERICS.FLOAT_ZERO
        }
        
    }
    
}

