//
//  PresentedCountryData.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let presentedCountryData = try? newJSONDecoder().decode(PresentedCountryData.self, from: jsonData)

import Foundation

// MARK: - PresentedCountryData
class PresentedCountryData: Codable {
    let response: Response
    let resultData: ResultData
    
    init(response: Response, resultData: ResultData) {
        self.response = response
        self.resultData = resultData
    }
}

// MARK: - Response
class Response: Codable {
    let errorCode: Int
    let errorMessage: String
    
    init(errorCode: Int, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}

// MARK: - ResultData
class ResultData: Codable {
    let presentedCountries: PresentedCountries
    
    enum CodingKeys: String, CodingKey {
        case presentedCountries = "PresentedCountries"
    }
    
    init(presentedCountries: PresentedCountries) {
        self.presentedCountries = presentedCountries
    }
}

// MARK: - PresentedCountries
class PresentedCountries: Codable {
    let countryList: [CountryList]
    
    init(countryList: [CountryList]) {
        self.countryList = countryList
    }
}

// MARK: - CountryList
class CountryList: Codable {
    let countryImageURL: String
    var cities: [String]
    let countryCode, countryName: String
    
    enum CodingKeys: String, CodingKey {
        case countryImageURL = "countryImageUrl"
        case cities, countryCode, countryName
    }
    
    init(countryImageURL: String, cities: [String], countryCode: String, countryName: String) {
        self.countryImageURL = countryImageURL
        self.cities = cities
        self.countryCode = countryCode
        self.countryName = countryName
    }
}
