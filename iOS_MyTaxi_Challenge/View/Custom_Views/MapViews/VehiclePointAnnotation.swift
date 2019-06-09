//
//  VehiclePointAnnotation.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class VehiclePointAnnotation: MKPointAnnotation {
    
    var commonPlaceData: CommonPlaceData?
    
    init(data: CommonPlaceData) {
        self.commonPlaceData = data
    }
    
}
