//
//  MapViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class MapViewModel {
    
    var vehicleDataArray = Dynamic(Array<VehicleData>())
    
    func getDataIntoViewModel(data: Array<VehicleData>) {
        self.vehicleDataArray.value = data
    }
    func returnVehicleDataArray() -> Array<VehicleData> {
        return vehicleDataArray.value
    }
    
}
