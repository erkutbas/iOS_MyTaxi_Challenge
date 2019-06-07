//
//  WarningViewController.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class WarningViewController: PermissionTemplateViewController {
    
    weak var delegate: ViewAnimationTrigger?
    
    lazy var customButtonView: PermissionButtonView = {
        let temp = PermissionButtonView(frame: CGRect(x: 0, y: 0, width: 240, height: 50))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
//        temp.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.8, blue: 0.8823529412, alpha: 1)
        temp.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.1882352941, blue: 0.3137254902, alpha: 1)
        temp.buttonPrompt.text = LocalizedConstants.TitlePrompts.chooseCountry
        return temp
    }()
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        setStackViewPrompts()
        setCenterViewImages()
        configureViewControllerSettings()
        addCustomViews()
        addGestureRecognizerToCustomView()
    }
    
    /*
    override func addGestureToPermissionButton() {
        self.configureGestureRecognizerToPermissionButtuon()
    }*/

}

// MARK: - major functions
extension WarningViewController {
    
    private func configureViewControllerSettings() {
        self.view.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1).withAlphaComponent(0.5)
        self.iconContainer.isHidden = true
        self.locationPermissionButton.isHidden = true
    }
    
    private func addGestureRecognizerToCustomView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.buttonPressed)
        tapGesture.delegate = self
        self.customButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func setStackViewPrompts() {
        self.mainSubject.text = LocalizedConstants.PermissionPrompts.warning
        self.detailedInformation.text = LocalizedConstants.PermissionPrompts.warningDetail
    }
    
    private func setCenterViewImages() {
        if let centerTopImage = UIImage(named: "warning.jpg") {
            self.centerViewTopImage.image = centerTopImage
        }
        
    }
    
    private func addCustomViews() {
        self.centerView.addSubview(customButtonView)
        
        NSLayoutConstraint.activate([
            customButtonView.leadingAnchor.constraint(equalTo: self.centerView.leadingAnchor, constant: 20),
            customButtonView.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor, constant: -20),
            customButtonView.heightAnchor.constraint(equalToConstant: 50),
            customButtonView.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 20)
            
            ])
        
        
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension WarningViewController: UIGestureRecognizerDelegate {

    @objc fileprivate func buttonPressed(_ sender: UITapGestureRecognizer) {
        customButtonView.startAnimationCommon()
        self.dismiss(animated: true, completion: nil)
        delegate?.triggerAnimation(direction: nil)
    }
    
}

// MARK: - selector extension
fileprivate extension Selector {
    static let buttonPressed = #selector(WarningViewController.buttonPressed)
}

