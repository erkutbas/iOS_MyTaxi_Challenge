//
//  ApiCallManager.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class ApiCallManager {
    public static let shared = ApiCallManager()
    
    private var urlSession: URLSession {
        get {
            let urlSessionConfiguration = URLSessionConfiguration()
            urlSessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
            urlSessionConfiguration.urlCache = URLCache.shared
            return URLSession(configuration: urlSessionConfiguration)
        }
    }
    
    /// Description: generic url request function
    ///
    /// - Parameters:
    ///   - type: any codable class
    ///   - useCache: to specify that request using cache to store urlresponse
    ///   - urlRequest: urlRequest to specified API type
    ///   - completion: decoded json data object
    /// - Author: Erkut Bas
    func startUrlRequest<T: Codable>(_ type: T.Type, useCache: Bool, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        if useCache {
            self.getDataByCheckingCache(type, urlRequest: urlRequest, completion: completion)
        } else {
            self.taskHandler(type: type, useCache: false, urlRequest: urlRequest, completion: completion)
        }
        
    }
    
    private func taskHandler<T:Codable>(type: T.Type, useCache: Bool, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("error : \(error)")
            }
            if let data = data {
                do {
                    let dataDecoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataDecoded))
                    // if says use cache, let's store response data to cache
                    if useCache {
                        if let response = response as? HTTPURLResponse {
                            self.storeDataToCache(urlResponse: response, urlRequest: urlRequest, data: data)
                        }
                    }
                    
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(BackendApiError.missingDataError))
            }
            
        }
        
        task.resume()
    }
    
    private func getDataByCheckingCache<T: Codable>(_ type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        if let data = self.checkDataExistsInCahce(urlRequest: urlRequest) {
            
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(parsedData))
            } catch let error {
                completion(.failure(error))
            }
            
        } else {
            self.taskHandler(type: type, useCache: true, urlRequest: urlRequest, completion: completion)
        }
        
    }
    
    private func checkDataExistsInCahce(urlRequest: URLRequest) -> Data? {
        guard let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) else { return nil }
        return cachedResponse.data
    }
    
    private func storeDataToCache(urlResponse: URLResponse, urlRequest: URLRequest, data: Data) {
        let cachedUrlResponse = CachedURLResponse(response: urlResponse, data: data)
        URLCache.shared.storeCachedResponse(cachedUrlResponse, for: urlRequest)
    }
    
    /// Description: creates url request for google api calls
    ///
    /// - Parameter googleApiCallStruct: required attributes to create url components and request
    /// - Returns: Url request
    func createUrlRequest(apiCallInputStruct: ApiCallInputStruct) -> URLRequest? {
        
        let urlString = apiCallInputStruct.urlString
        guard let urlInitial = URL(string: urlString) else { return nil }
        var urlComponent = URLComponents(url: urlInitial, resolvingAgainstBaseURL: false)
        
        switch apiCallInputStruct.callType {
        case .presentedCountries:
            // there is no need for extra query parameters
            break
        case .listOfVehiclesDefault:
            // there is no need for extra query parameters
            break
        case .listOfVehiclesCallByOutsider:
            // there is some code needing here :D
            
            guard let placeMark = apiCallInputStruct.placeMark else { return nil }
            guard let location = placeMark.location else { return nil }
            
            urlComponent?.queryItems = [URLQueryItem(name: "p2Lat", value: String(describing: Double(location.coordinate.latitude - 0.2))), URLQueryItem(name: "p1Lon", value: String(describing: Double(location.coordinate.longitude - 0.2))), URLQueryItem(name: "p1Lat", value: String(describing: Double(location.coordinate.latitude + 0.2))), URLQueryItem(name: "p2Lon", value: String(describing: Double(location.coordinate.longitude + 0.2)))]
            
        case .listOfVehiclesCallByInsider:
            urlComponent?.queryItems = [URLQueryItem(name: "p2Lat", value: apiCallInputStruct.p2Lat), URLQueryItem(name: "p1Lon", value: apiCallInputStruct.p1Lon), URLQueryItem(name: "p1Lat", value: apiCallInputStruct.p1Lat), URLQueryItem(name: "p2Lon", value: apiCallInputStruct.p2Lon)]
        }
        
        guard let component = urlComponent else { return nil }
        guard let url = component.url else { return nil }
        
        return URLRequest(url: url)
        
    }
    
}
