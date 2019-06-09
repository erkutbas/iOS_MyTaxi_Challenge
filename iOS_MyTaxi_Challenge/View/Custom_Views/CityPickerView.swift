//
//  CityPickerView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CityPickerView: BasePickerView {
    
    private var cityPickerViewModel = CityPickerViewModel()
    weak var delegate: PickerProtocols?

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        self.configureViewSettings()
    }
    
    deinit {
        cityPickerViewModel.cityListData.unbind()
    }
    
}

// MARK: - major functions
extension CityPickerView {
    
    private func configureViewSettings() {
        self.backgroundColor = UIColor.clear
        self.infoPicker.delegate = self
        self.infoPicker.dataSource = self
        self.infoLabel.text = LocalizedConstants.TitlePrompts.city
        self.activationManager(active: true)
        
        self.addListeners()
    }
    
    private func activationManager(active: Bool) {
        self.isHidden = active
    }
    
    private func addListeners() {
        cityPickerViewModel.cityListData.bind { (cityList) in
            self.reloadPickerData()
        }
    }
    
    private func reloadPickerData() {
        self.infoPicker.reloadAllComponents()
    }
    
    // outsider
    func setCitidata(cityList: Array<String>) {
        self.cityPickerViewModel.cityListData.value = cityList
        
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                if self.cityPickerViewModel.returnNumberOfComponents() <= 1 {
                    self.activationManager(active: true)
                } else {
                    self.activationManager(active: false)
                }
                
            }, completion: nil)
        }
        
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CityPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cityPickerViewModel.returnNumberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.cityPickerViewModel.returnCityName(index: row), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > 0 {
            delegate?.getSelectedCity(city: self.cityPickerViewModel.returnCityName(index: row))
        } else {
            delegate?.getSelectedCity(city: nil)
        }
    }
    
    
}


