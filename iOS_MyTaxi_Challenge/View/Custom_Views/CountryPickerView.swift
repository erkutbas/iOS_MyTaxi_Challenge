//
//  CountryPickerView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CountryPickerView: BasePickerView {

    private var countryPickerViewModel = CountryPickerViewModel()
    weak var delegate: PickerProtocols?
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
         
        self.configureViewSettings()
        self.addListeners()
    }
    
    deinit {
        countryPickerViewModel.countryListData.unbind()
    }
    
}

// MARK: - major functions
extension CountryPickerView {
    
    private func configureViewSettings() {
        self.backgroundColor = UIColor.clear
        self.infoPicker.delegate = self
        self.infoPicker.dataSource = self
    }
    
    private func addListeners() {
        countryPickerViewModel.countryListData.bind { (countryList) in
            self.reloadPickerData()
        }
    }
    
    private func reloadPickerData() {
        DispatchQueue.main.async {
            self.infoPicker.reloadAllComponents()
        }
    }
    
    // outsider
    func setCountryListData(data: Array<CountryList>) {
        self.countryPickerViewModel.setCountryListData(data: data)
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CountryPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("self.countryPickerViewModel.returnNumberOfComponents() : \(self.countryPickerViewModel.returnNumberOfComponents())")
        return self.countryPickerViewModel.returnNumberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.countryPickerViewModel.returnCountryName(index: row), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.getSelectedCountryInformation(countryData: self.countryPickerViewModel.returnSelectedCountry(index: row))
    }
    
}

