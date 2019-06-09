//
//  MainViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class MainViewModel: CommonViewModel {
    
    // dynamic components
    var apiCallStatus = Dynamic(ApiCallStatus.none)
    var feedDataToCountySelectionView = Dynamic(Array<CountryList>())
    var mapViewActivation = Dynamic(false)
    var unsuitableCountry = Dynamic(false)

    var presentedCountryData: PresentedCountryData?
    var currentCountryCode: String?
    
    func getPresentedCountries(apiCallInputStruct: ApiCallInputStruct, currentCountryCode: String) {
        
        self.currentCountryCode = currentCountryCode
        apiCallStatus.value = .process
        
        guard let urlRequest = ApiCallManager.shared.createUrlRequest(apiCallInputStruct: apiCallInputStruct) else { return }
        print("urlRequest : \(urlRequest)")
        ApiCallManager.shared.startUrlRequest(PresentedCountryData.self
        , useCache: true, urlRequest: urlRequest) { (result) in
            self.handleGenericResponse(response: result)
        }
        
    }
    
    func handleGenericResponse<T>(response: Result<T, Error>) where T : Decodable, T : Encodable {
        print("\(#function)")
       
        switch response {
        case .failure(let error):
            print("Prensented Countries Api Call Error : \(error)")
            
        case .success(let data):
            if let data = data as? PresentedCountryData {
                self.handlePresentedCountiesResponseData(data: data)
            }
        }
        
    }
    
    private func handlePresentedCountiesResponseData(data: PresentedCountryData) {
        self.presentedCountryData = data
        // first apicall status triggers, it closes the refreshing view
        apiCallStatus.value = .done
        // feed country list data
        feedDataToCountySelectionView.value = data.resultData.presentedCountries.countryList
        // then check current country
        self.checkCurrentCountryInsidePresentedCountries()
        
    }
    
    func returnPresentedCountries() -> PresentedCountryData? {
        guard let data = self.presentedCountryData else { return nil }
        
        for item in data.resultData.presentedCountries.countryList {
            print("item : \(item.countryCode)")
            print("item : \(item.countryName)")
            
            for item in item.cities {
                print("city : \(item)")
            }
        }
        
        return data
        
    }
    
    private func checkCurrentCountryInsidePresentedCountries() {
        guard let presentedData = returnPresentedCountries() else { return }
        guard let currentCountryCode = self.currentCountryCode else { return }
        
        var tempCountryCode = [String]()
        
        for item in presentedData.resultData.presentedCountries.countryList {
            tempCountryCode.append(item.countryCode)
        }
        
        let result = tempCountryCode.contains { (checker) -> Bool in
            if checker.lowercased() == currentCountryCode.lowercased() {
                return true
            } else {
                return false
            }
        }
        
        if result {
           // do nothing
        } else {
            self.unsuitableCountry.value = false
        }
        
    }
    
    
}
