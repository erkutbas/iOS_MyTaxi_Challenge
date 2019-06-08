//
//  CountryPickerView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CountryPickerView: BasePickerView {

    private var data = Array<String>()
    
    init(frame: CGRect, data: Array<String>) {
        super.init(frame: frame)
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        
        self.configureViewSettings()
    }
    
}

// MARK: - major functions
extension CountryPickerView {
    
    private func configureViewSettings() {
        self.backgroundColor = UIColor.clear
        self.infoPicker.delegate = self
        self.infoPicker.dataSource = self
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CountryPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.data[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        let selectedCountry = slideMenuViewModel.returnCountryDataByIndex(index: row)
        //        slideMenuViewModel.selectedCountry.value = selectedCountry
        //        delegate?.returnSelectedCountry(country: selectedCountry)
    }
    
    
}
