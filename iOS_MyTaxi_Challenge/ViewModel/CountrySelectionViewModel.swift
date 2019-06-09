//
//  CountrySelectionViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class CountrySelectionViewModel {
    
    var selectedDataFromPickers = CountrySelectionStruct()
    
    // dynamic variables
    var countryTitle = Dynamic(String())
    var cityTitle = Dynamic(String())
    
    func setSelectedCountry(country: CountryList) {
        if country.countryCode == CONSTANT.CHARS.DEFAULT_COUNTRY_CODE {
            selectedDataFromPickers.country = nil
        } else {
            selectedDataFromPickers.country = country
        }
    }
    
    func setSelectedCity(city: String?) {
        selectedDataFromPickers.city = city
    }
    
    func returnSelectedCountryData() -> CountrySelectionStruct {
        
        triggerViewTitleChanges()
        
        return self.selectedDataFromPickers
    }
    
    private func triggerViewTitleChanges() {
        if let city = self.selectedDataFromPickers.city {
            cityTitle.value = city
        } else {
            cityTitle.value = LocalizedConstants.TitlePrompts.selectCountryDetail
        }
        
        if let countryData = self.selectedDataFromPickers.country {
            countryTitle.value = countryData.countryName
        } else {
            countryTitle.value = LocalizedConstants.TitlePrompts.selectCountry
        }
    }
    
}
