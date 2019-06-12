//
//  Base.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import MapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViewConfigurations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareViewConfigurations() {
        
    }
    
}

class BaseBottomSheetView: UIView {
    
    var mainStackViewLeadingConstraint = NSLayoutConstraint()
    
    lazy var topBarView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [stackViewForDirectionIcon, stackViewForSheetInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.distribution = .fillProportionally
        
        
        return temp
    }()
    
    lazy var stackViewForSheetInformation: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [mainSubject, detailedInformation])
        temp.isUserInteractionEnabled = true
        temp.spacing = 4
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let mainSubject: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .left
        temp.contentMode = .center
        temp.text = LocalizedConstants.TitlePrompts.selectCountry
        temp.font = UIFont(name: "Avenir-Heavy", size: 18)
        temp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return temp
    }()
    
    let detailedInformation: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.lightGray
        temp.textAlignment = .left
        temp.contentMode = .center
        temp.text = LocalizedConstants.TitlePrompts.selectCountryDetail
        temp.font = UIFont(name: "Avenir-Medium", size: 14)
        temp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return temp
    }()
    
    lazy var stackViewForDirectionIcon: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [directionIcon])
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    lazy var directionIcon: UIImageView = {
        let temp = UIImageView()
        temp.isUserInteractionEnabled = true
        temp.image = UIImage(named: "direction1")?.withRenderingMode(.alwaysTemplate)
        temp.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.contentMode = .top
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViewConfigurations()
        reArrangeViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareViewConfigurations() {
        self.clipsToBounds = true
        self.addViews()
    }
    
    func reArrangeViewConstraints() {}
    
    func addViews() {
        self.addSubview(topBarView)
        self.topBarView.addSubview(mainStackView)
        
        self.mainStackViewLeadingConstraint = self.mainStackView.leadingAnchor.constraint(equalTo: self.topBarView.leadingAnchor, constant: 50)
        
        NSLayoutConstraint.activate([
            
            topBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBarView.topAnchor.constraint(equalTo: self.topAnchor),
//            topBarView.heightAnchor.constraint(equalToConstant: 100),
            
            mainStackView.centerYAnchor.constraint(equalTo: self.topBarView.centerYAnchor),
            //mainStackView.leadingAnchor.constraint(equalTo: self.topBarView.leadingAnchor, constant: 50)
            mainStackViewLeadingConstraint
            
            ])
    }
    
}

class BasePickerView: UIView {
    
    lazy var stackViewForPickerView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [infoLabel, infoPicker])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 5
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let infoLabel: UILabel = {
        let temp = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        temp.numberOfLines = 0
        temp.textAlignment = .center
        temp.contentMode = .center
        temp.lineBreakMode = .byWordWrapping
        temp.text = LocalizedConstants.TitlePrompts.country
        temp.font = UIFont(name: "Avenir-Medium", size: 18)
        temp.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return temp
    }()
    
    // transparent toolbar
    lazy var toolbar: UIToolbar = {
        let temp = UIToolbar()
        temp.barStyle = .default
        temp.isTranslucent = true
        temp.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.backgroundColor = UIColor.clear
        temp.barTintColor = UIColor.clear
        temp.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        temp.sizeToFit()
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    lazy var infoPicker: UIPickerView = {
        let temp = UIPickerView()
        temp.isUserInteractionEnabled = true
        temp.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViewConfigurations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareViewConfigurations() {
        addViews()
    }
    
    func addViews() {
        self.addSubview(stackViewForPickerView)
        
        NSLayoutConstraint.activate([
            
            stackViewForPickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewForPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewForPickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewForPickerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            ])
    }
    
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewConfigurations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Receive memory warning from \(String(describing: self))")
    }
    
    func prepareViewConfigurations() {}
}

class PermissionTemplateViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.contentMode = .scaleAspectFill
        //temp.image = UIImage(named: "background.png")
        return temp
    }()
    
    lazy var centerViewContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.layer.cornerRadius = 15
        temp.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        temp.layer.shadowOffset = .zero
        temp.layer.shadowOpacity = 1;
        temp.layer.shadowRadius = 5;
        return temp
    }()
    
    lazy var centerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.layer.cornerRadius = 15
        return temp
    }()
    
    lazy var centerViewTopImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.isUserInteractionEnabled = false
        //temp.image = UIImage(named: "wing.jpg")
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    lazy var iconContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.layer.cornerRadius = 50
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return temp
    }()
    
    lazy var iconImageContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 47
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 5)
        temp.layer.shadowOpacity = 0.8;
        temp.layer.shadowRadius = 5;
        return temp
    }()
    
    lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.clipsToBounds = true
        //temp.image = UIImage(named: "location.jpg")
        temp.contentMode = .scaleAspectFill
        temp.layer.cornerRadius = 47
        return temp
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [stackViewForUserInfo])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 20
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fill
        
        
        return temp
    }()
    
    lazy var stackViewForUserInfo: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [mainSubject, detailedInformation])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 12
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let mainSubject: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.contentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 24)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    let detailedInformation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        
        return label
    }()
    
    lazy var locationPermissionButton: PermissionButtonView = {
        let temp = PermissionManager.shared.createPermissionButtonView(permissionType: .location)
        temp.translatesAutoresizingMaskIntoConstraints = false
        //temp.isUserInteractionEnabled = false
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewConfigurations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Receive memory warning from \(String(describing: self))")
    }
    
    func prepareViewConfigurations() {
        addViews()
    }
    
    func addGestureToPermissionButton() {
        
    }
    
    func addViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(centerViewContainer)
        self.centerViewContainer.addSubview(centerView)
        self.centerView.addSubview(centerViewTopImage)
        self.centerView.addSubview(iconContainer)
        self.iconContainer.addSubview(iconImageContainer)
        self.iconImageContainer.addSubview(iconImageView)
        self.centerView.addSubview(mainStackView)
        self.centerView.addSubview(locationPermissionButton)
        //self.centerView.addSubview(locationPermissionButton)
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            centerViewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            centerViewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            centerViewContainer.heightAnchor.constraint(equalToConstant: 430),
            centerViewContainer.widthAnchor.constraint(equalToConstant: 300),
            
            centerView.leadingAnchor.constraint(equalTo: self.centerViewContainer.leadingAnchor),
            centerView.trailingAnchor.constraint(equalTo: self.centerViewContainer.trailingAnchor),
            centerView.topAnchor.constraint(equalTo: self.centerViewContainer.topAnchor),
            centerView.bottomAnchor.constraint(equalTo: self.centerViewContainer.bottomAnchor),
            
            centerViewTopImage.leadingAnchor.constraint(equalTo: self.centerView.leadingAnchor),
            centerViewTopImage.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor),
            centerViewTopImage.topAnchor.constraint(equalTo: self.centerView.topAnchor),
            centerViewTopImage.heightAnchor.constraint(equalToConstant: 150),
            
            //locationViewContainer.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor, constant: -12),
            iconContainer.centerXAnchor.constraint(equalTo: self.centerView.centerXAnchor),
            iconContainer.topAnchor.constraint(equalTo: self.centerView.topAnchor, constant: 110),
            iconContainer.heightAnchor.constraint(equalToConstant: 100),
            iconContainer.widthAnchor.constraint(equalToConstant: 100),
            
            iconImageContainer.centerXAnchor.constraint(equalTo: self.iconContainer.centerXAnchor),
            iconImageContainer.centerYAnchor.constraint(equalTo: self.iconContainer.centerYAnchor),
            iconImageContainer.heightAnchor.constraint(equalToConstant: 94),
            iconImageContainer.widthAnchor.constraint(equalToConstant: 94),
            
            iconImageView.centerXAnchor.constraint(equalTo: self.iconImageContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.iconImageContainer.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 94),
            iconImageView.widthAnchor.constraint(equalToConstant: 94),
            
            mainStackView.topAnchor.constraint(equalTo: self.iconContainer.bottomAnchor, constant: 10),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerView.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: 260),
            //mainStackView.heightAnchor.constraint(equalToConstant: 175),
            
            locationPermissionButton.leadingAnchor.constraint(equalTo: self.centerView.leadingAnchor, constant: 20),
            locationPermissionButton.trailingAnchor.constraint(equalTo: self.centerView.trailingAnchor, constant: -20),
            locationPermissionButton.heightAnchor.constraint(equalToConstant: 50),
            locationPermissionButton.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 20)
            
            ])
        
    }
    
}

class BaseMainViewTemplate: BaseView {
    
}
