//
//  MainViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import CoreLocation

class MainViewModel: CommonViewModel {
    
    // dynamic components
    var apiCallStatus = Dynamic(ApiCallStatus.none)
    var feedDataToCountySelectionView = Dynamic(Array<CountryList>())
    var unsuitableCountry = Dynamic(false)
    //var selectedCountryDataStruct = Dynamic(CountrySelectionStruct())
    var backgroundImageChanger = Dynamic(String())
    var poiListApicallStatus = Dynamic(ApiCallStatus.none)
    
    // mapview requirements
    var mapViewRequiredData: MapViewRequiredParams?
    var regionLocation: CLLocation?

    // presented country checkers
    var presentedCountryData: PresentedCountryData?
    var currentCountryCode: String?
    
    func getPresentedCountries(apiCallInputStruct: ApiCallInputStruct, currentCountryCode: String?) {

        if let currentCountryCode = currentCountryCode {
            self.currentCountryCode = currentCountryCode
        }

        apiCallStatus.value = .process
        
        guard let urlRequest = ApiCallManager.shared.createUrlRequest(apiCallInputStruct: apiCallInputStruct) else { return }
        print("urlRequest : \(urlRequest)")
        ApiCallManager.shared.startUrlRequest(PresentedCountryData.self
        , useCache: true, urlRequest: urlRequest) { (result) in
            self.handleGenericResponse(response: result)
        }
        
    }
    
    func getListOfVehicles(apiCallStruct: ApiCallInputStruct) {
        print("\(#function)")
        
        poiListApicallStatus.value = .process
        self.retrieveCoordinateData(apiCallStruct: apiCallStruct)
        
        guard let urlRequest = ApiCallManager.shared.createUrlRequest(apiCallInputStruct: apiCallStruct) else { return }
        
        ApiCallManager.shared.startUrlRequest(PoiListData.self, useCache: false, urlRequest: urlRequest) { (result) in
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
            } else if let data = data as? PoiListData {
                self.handlePoiListData(data: data)
            }
        }
        
    }
    
    private func retrieveCoordinateData(apiCallStruct: ApiCallInputStruct) {
        if let coordinate = apiCallStruct.coordinate {
            self.regionLocation = coordinate
        } else if let placeMark = apiCallStruct.placeMark {
            self.regionLocation = placeMark.location
        }
    }
    
    private func handlePoiListData(data: PoiListData) {
        print("\(#function)")
        
        guard let poiList = data.poiList else { return }
        print("Total Data : \(poiList.count)")

        var vehicleDataArray = Array<VehicleData>()
        for item in poiList {
            vehicleDataArray.append(VehicleData(data: item))
        }
        
        self.createMapViewRequeiredParams(vehicleArray: vehicleDataArray)
        
        poiListApicallStatus.value = .done
    }
    
    private func createMapViewRequeiredParams(vehicleArray: Array<VehicleData>)  {
        guard let regionLocation = self.regionLocation else { return }
        self.mapViewRequiredData = MapViewRequiredParams(location: regionLocation, vehicleArray: vehicleArray)
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
        
//        for item in data.resultData.presentedCountries.countryList {
//            print("item : \(item.countryName)")
//
//            for item in item.cities {
//                print("city : \(item)")
//            }
//        }
        
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
    
    func returnMapViewRequiredParams() -> MapViewRequiredParams? {
        guard let data = self.mapViewRequiredData else { return nil }
        return data
    }
    
    func changeBackgroundImage(data: CountrySelectionStruct) {
//        self.selectedCountryDataStruct.value = data
        
        if let country = data.country {
            self.backgroundImageChanger.value = country.countryImageURL
        } else {
            self.backgroundImageChanger.value = CONSTANT.CHARS.SPACE
        }
        
    }
    
}
