//
//  CountryPickerViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class CountryPickerViewModel {
    var countryListData = Dynamic(Array<CountryList>())
    
    func returnNumberOfComponents() -> Int {
        return countryListData.value.count
    }
    
    func returnCountryName(index: Int) -> String {
        return countryListData.value[index].countryName
    }
    
    func returnSelectedCountryCities(index: Int) -> Array<String> {
        return countryListData.value[index].cities
    }
    
    func returnSelectedCountry(index: Int) -> CountryList {
        return countryListData.value[index]
    }
    
    func setCountryListData(data: Array<CountryList>) {
        
        var indexPlaceSelectObjcect = 0
        
        if let index = data.firstIndex(where: { $0.countryCode.lowercased() == CONSTANT.CHARS.DEFAULT_COUNTRY_CODE.lowercased() }) {
            indexPlaceSelectObjcect = index
        }
        
        print("indexPlaceSelectedObject : \(indexPlaceSelectObjcect)")

        let reArrangeArray = rearrange(array: data, fromIndex: indexPlaceSelectObjcect, toIndex: 0)
        for item in reArrangeArray {
            item.cities.insert(LocalizedConstants.TitlePrompts.pleaseChoose, at: 0)
        }
        
        self.countryListData.value = reArrangeArray
        
    }
    
    func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
}
