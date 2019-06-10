//
//  MapViewModel.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel: CommonViewModel {
    
    var mapTrigger = Dynamic(MapUpdateTrigger.none)
    var vehicleDataArray: Array<VehicleData>?
    var regionLocation: CLLocation!
    var countrySelectedData = CountrySelectionStruct()
    var apiCallStatus = Dynamic(ApiCallStatus.none)
    
    func getDataIntoViewModel(data: MapViewRequiredParams) {
        self.vehicleDataArray = data.vehicleArray
        self.regionLocation = data.location
        self.mapTrigger.value = .outsider
    }
    
    func returnVehicleDataArray() -> Array<VehicleData>? {
        guard let data = vehicleDataArray else { return nil }
        return data
    }
    
    func returnRegionLocation() -> CLLocation {
        return regionLocation
    }
    
    func returnRegionCoordinate() -> CLLocationCoordinate2D {
        print("regionLocation.coordinate : \(regionLocation.coordinate)")
        return regionLocation.coordinate
    }
    
    func returnTotalNumberOfTaxi() -> Int {
        guard let data = vehicleDataArray else { return 0 }
        return data.count
    }

    func updateMapView(apiCallData: ApiCallInputStruct) {
        
        self.apiCallStatus.value = .process
        
        guard let urlRequest = ApiCallManager.shared.createUrlRequest(apiCallInputStruct: apiCallData) else { return }
        print("UrlRequest : \(urlRequest)")
        
        ApiCallManager.shared.startUrlRequest(PoiListData.self, useCache: false, urlRequest: urlRequest) { (result) in
            self.handleGenericResponse(response: result)
        }
        
    }
    
    func handleGenericResponse<T>(response: Result<T, Error>) {
        switch response {
        case .failure(let error):
            print("Something goes wrong by getting new data : \(error)")
        case .success(let data):
            if let data = data as? PoiListData {
                self.handlePoiListData(data: data)
            }
        }
    }
    
    private func handlePoiListData(data: PoiListData) {
        print("\(#function)")
        
        guard let poiList = data.poiList else { return }
        print("Total Data : \(poiList.count)")
        
        vehicleDataArray = Array<VehicleData>()
        for item in poiList {
            vehicleDataArray?.append(VehicleData(data: item))
        }
        
        self.mapTrigger.value = .insider
        self.apiCallStatus.value = .done
        
    }
}
