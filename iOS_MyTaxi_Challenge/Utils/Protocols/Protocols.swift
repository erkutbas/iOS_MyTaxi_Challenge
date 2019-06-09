//
//  Protocols.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

protocol ViewAnimationTrigger: class {
    func triggerAnimation(direction: Direction?)
}

extension ViewAnimationTrigger {
    func triggerAnimation(direction: Direction?) {}
}

protocol PickerProtocols: class {
    func getSelectedCountryInformation(countryData: CountryList)
    func getSelectedCity(city: String?)
}

extension PickerProtocols {
    func getSelectedCountryInformation(countryData: CountryList) {}
    func getSelectedCity(city: String?) {}
}

protocol CommonViewModel {
    func handleGenericResponse<T: Codable>(response: Result<T, Error>)
}

protocol CommonPlaceData {}
