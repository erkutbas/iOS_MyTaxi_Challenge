//
//  CityPickerViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class CityPickerViewModel {
    var cityListData = Dynamic(Array<String>())
    
    func returnNumberOfComponents() -> Int {
        return cityListData.value.count
    }
    
    func returnCityName(index: Int) -> String {
        return cityListData.value[index]
    }
    
    func setCityListData(data: Array<String>) {
        self.cityListData.value = data
    }
}
