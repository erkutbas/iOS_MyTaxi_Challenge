//
//  PermissionButtonView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class PermissionButtonView: UIView {
    
    private var permissionResult: PermissionResult!
    
    lazy var iconContainerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = self.frame.height / 2
        return temp
    }()
    
    lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    lazy var buttonPrompt: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont(name: "Avenir-Medium", size: 15)
        temp.lineBreakMode = .byWordWrapping
        temp.contentMode = .center
        temp.textAlignment = .center
        temp.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.numberOfLines = 0
        
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureViewSettings()
    }
    
    init(frame: CGRect, permissionButtonProperty: PermissionButtonProperty) {
        super.init(frame: frame)
        
        addViews()
        configureViewSettings()
        setNecessarryItems(permissionButtonProperty: permissionButtonProperty)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - major functions
extension PermissionButtonView {
    
    private func addViews() {
        self.addSubview(iconContainerView)
        self.addSubview(buttonPrompt)
        self.iconContainerView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            
            iconContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            iconContainerView.heightAnchor.constraint(equalToConstant: self.frame.height),
            iconContainerView.widthAnchor.constraint(equalToConstant: self.frame.height),
            
            iconImageView.leadingAnchor.constraint(equalTo: self.iconContainerView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.iconContainerView.topAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: self.iconContainerView.trailingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.iconContainerView.bottomAnchor),
            //iconImageView.heightAnchor.constraint(equalToConstant: self.frame.height),
            //iconImageView.widthAnchor.constraint(equalToConstant: self.frame.height),
            
            //            buttonPrompt.leadingAnchor.constraint(equalTo: self.iconContainerView.trailingAnchor, constant: 16),
            buttonPrompt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonPrompt.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonPrompt.widthAnchor.constraint(equalToConstant: 160),
            buttonPrompt.heightAnchor.constraint(equalToConstant: self.frame.height)
            
            ])
    }
    
    private func configureViewSettings() {
        self.layer.cornerRadius = self.frame.height / 2
        
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
        
    }
    
    fileprivate func registerPermissionResult(_ permissionResult: PermissionResult) {
        self.permissionResult = permissionResult
        
        switch permissionResult {
        case .authorized:
            self.isUserInteractionEnabled = false
        case .denied, .notDetermined:
            self.isUserInteractionEnabled = true
        }
    }
    
    private func setNecessarryItems(permissionButtonProperty: PermissionButtonProperty) {
        self.iconContainerView.backgroundColor = permissionButtonProperty.backgroundColorOfIconContainer
        self.iconImageView.image = permissionButtonProperty.image
        self.buttonPrompt.text = permissionButtonProperty.buttonPrompt
        self.backgroundColor = permissionButtonProperty.backgroundColor
        
        registerPermissionResult(permissionButtonProperty.permissionResult)
        
    }
    
}

// MARK: - functions called from outside
extension PermissionButtonView {
    
    func getPermissionResult() -> PermissionResult {
        return permissionResult
    }
    
    func updateButtonView(permissionButtonProperty: PermissionButtonProperty) {
        setNecessarryItems(permissionButtonProperty: permissionButtonProperty)
    }
    
}

