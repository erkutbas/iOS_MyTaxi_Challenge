//
//  LocationManager.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let shared = LocationManager()
    
    private var locationManager: CLLocationManager!
    
    // completion handler
    typealias placeMarkCompletion = (Result<[CLPlacemark], Error>) -> Void
    typealias locationDataCompletion = (CLLocation) -> Void
    private var completionHandlerForLocationUpdates: locationDataCompletion?
    private var didCLGeocoderDataGet = false
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        locationManager.pausesLocationUpdatesAutomatically = true // Enable automatic pausing
    }
    
    /// Description: starts updating location
    func startUpdateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    /// Description: stops updating location
    func stopUpdateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
    /// Description: It's called to get current location. Starts location update and stop after getting location
    ///
    /// - Parameter completion: completion containing cllocation object
    func getCurrentLocationData(completion: @escaping locationDataCompletion) {
        if CLLocationManager.locationServicesEnabled() {
            self.startUpdateLocation()
            completionHandlerForLocationUpdates = { (location) -> Void in
                completion(location)
                self.stopUpdateLocation()
            }
        }
        
    }
    
    func getCurrentPlaceMarkData(completion: @escaping placeMarkCompletion) {
        
        self.didCLGeocoderDataGet = false
        
        getCurrentLocationData { (location) in
            // didupdatelocations triggers more than once until it stopsupdatinglocation. That's why we need to keep clgeocoder function call in control. Because afterward it triggers a view controller presentation.
            if !self.didCLGeocoderDataGet {
                self.didCLGeocoderDataGet = true
                self.startGettingCLGeocoderResult(location, completion: completion)
            }
            
        }
    }
    
    private func startGettingCLGeocoderResult(_ location: CLLocation, completion: @escaping placeMarkCompletion) {
        print("\(#function)")
        // in case location update still works
        self.stopUpdateLocation()
        
        let clgeocoder = CLGeocoder()
        clgeocoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) in
            if let error = error {
                print("Something goes terribly wrong while getting placemarks : \(error)")
                completion(.failure(BackendApiError.geoCoderFailed))
            }
            
            if let placeMarksData = placeMarks {
                completion(.success(placeMarksData))
            }
            
        })
        
    }
    
    func startGettingLocationDataByAddress(address: String, completion: @escaping placeMarkCompletion) {
        let clgeocoder = CLGeocoder()
        clgeocoder.geocodeAddressString(address) { (placeMarks, error) in
            if let error = error {
                print("Something goes terribly wrong while getting placemarks : \(error)")
                completion(.failure(error))
            }
            
            if let placeMarksData = placeMarks {
                completion(.success(placeMarksData))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            self.locationManager.stopUpdatingLocation()
            return
        }
        // Notify the user of any errors.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last  else {
            return
        }
        completionHandlerForLocationUpdates?(location)
        
    }
    
}
