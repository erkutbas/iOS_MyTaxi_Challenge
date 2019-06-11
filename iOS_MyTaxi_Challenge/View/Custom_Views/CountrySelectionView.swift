//
//  CountrySelectionView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CountrySelectionView: BaseBottomSheetView {
    
    private var countrySelectionViewModel = CountrySelectionViewModel()
    
    weak var delegate: ViewAnimationTrigger?
    private var direction: Direction = .up
    
    typealias typealiasForSelectedCountryData = (CountrySelectionStruct) -> Void
    private var closureForSelectedCountryData: typealiasForSelectedCountryData?
    
    lazy var countryPickerView: CountryPickerView = {
        let temp = CountryPickerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.delegate = self
        return temp
    }()

    lazy var cityPickerView: CityPickerView = {
        let temp = CityPickerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.delegate = self
        return temp
    }()
    
    lazy var doneButton: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.donePressed))
        temp.image = UIImage(named: "check.png")?.withRenderingMode(.alwaysTemplate)
        temp.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.layer.cornerRadius = 20
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = .zero
        temp.layer.shadowOpacity = 0.5;
        temp.layer.shadowRadius = 5;
        return temp
    }()
    
    var mainScreenBounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    // blur view
    lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let temp = UIVisualEffectView(effect: effect)
        temp.isUserInteractionEnabled = false
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.masksToBounds = true
        temp.isHidden = true
        return temp
    }()
    
    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        configureViewSettings()
        addBlurEffect()
        
    }
    
    deinit {
        countrySelectionViewModel.cityTitle.unbind()
        countrySelectionViewModel.countryTitle.unbind()
    }
    
}

// MARK: - major functions
extension CountrySelectionView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.6, green: 0.5607843137, blue: 0.6352941176, alpha: 1)
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        self.reArrangeTopBarViewConstraint()
        self.activationManager(active: false)
        self.addPickerViews()
        self.addDoneButton()
        self.addListeners()
    }
    
    private func reArrangeTopBarViewConstraint() {
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalToConstant: 100),
            ])
    }
    
    private func addBlurEffect() {
        
        self.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
        
    }
    
    private func addPickerViews() {
        self.addSubview(countryPickerView)
        self.addSubview(cityPickerView)

        NSLayoutConstraint.activate([

            countryPickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countryPickerView.topAnchor.constraint(equalTo: self.topBarView.bottomAnchor, constant: 20),
            countryPickerView.widthAnchor.constraint(equalToConstant: 300),
            countryPickerView.heightAnchor.constraint(equalToConstant: 220),

            cityPickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cityPickerView.topAnchor.constraint(equalTo: self.countryPickerView.bottomAnchor, constant: 20),
            cityPickerView.widthAnchor.constraint(equalToConstant: 300),
            cityPickerView.heightAnchor.constraint(equalToConstant: 220)

            ])

    }
    
    private func feedDataToCountryPickerView(data: Array<CountryList>) {
        self.countryPickerView.setCountryListData(data: data)
    }
    
    private func addDoneButton() {
        self.addSubview(doneButton)
        NSLayoutConstraint.activate([
            
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            doneButton.topAnchor.constraint(equalTo: self.countryPickerView.topAnchor, constant: -10),
            //doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 40),
            
            ])
    }
    
    private func addListeners() {
        countrySelectionViewModel.cityTitle.bind { (cityString) in
            self.setCityTitle(cityTitle: cityString)
        }
        
        countrySelectionViewModel.countryTitle.bind { (countryString) in
            self.setCountryTitle(countryTitle: countryString)
        }
    }
    
    private func setCityTitle(cityTitle: String) {
        DispatchQueue.main.async {
            UIView.transition(with: self.detailedInformation, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.detailedInformation.text = cityTitle
            }, completion: nil)
        }
    }
    
    private func setCountryTitle(countryTitle: String) {
        DispatchQueue.main.async {
            UIView.transition(with: self.mainSubject, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.mainSubject.text = countryTitle
            }, completion: nil)
        }
    }
    
    private func activationManager(active: Bool) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = active
        }
    }
    
    // outsider functions
    func setPresentedCountriesData(data: Array<CountryList>) {
        self.countryPickerView.setCountryListData(data: data)
        self.activationManager(active: true)
    }
    
    func listenSelectedCountryData(completion: @escaping typealiasForSelectedCountryData) {
        closureForSelectedCountryData = completion
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension CountrySelectionView: UIGestureRecognizerDelegate {
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGesture.delegate = self
        self.topBarView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        self.bottonSheetAnimationManager()
    }
    
    private func bottonSheetAnimationManager() {
        // outerViewAnimation triggers outside view animations.
        outerViewAnimations(direction: self.direction)
        mainViewAnimations()
    }
    
    fileprivate func mainViewAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch self.direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.directionIcon.transform = .identity
                self.blurView.isHidden = true
                self.backgroundColor = #colorLiteral(red: 0.6, green: 0.5607843137, blue: 0.6352941176, alpha: 1)
                
            case .up:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE_ACTIVE, width: self.frame.width, height: self.frame.height)
                self.direction = .down
                self.directionIcon.transform = CGAffineTransform(scaleX: 1, y: -1)
                self.blurView.isHidden = false
                self.backgroundColor = UIColor.clear
                
            default:
                break
            }
            
        }, completion: nil)
    }
    
    fileprivate func outerViewAnimations(direction: Direction) {
        switch direction {
        case .down:
            delegate?.triggerAnimation(direction: .up)
        case .up:
            delegate?.triggerAnimation(direction: .down)
        default:
            break
        }
    }
    
    private func closeButtonSheetView(direction: Direction) {
        delegate?.triggerAnimation(direction: direction)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height, width: self.frame.width, height: self.frame.height)
//                self.direction = .up
//                self.directionIcon.transform = .identity
//                self.blurView.isHidden = true
//                self.backgroundColor = #colorLiteral(red: 0.6, green: 0.5607843137, blue: 0.6352941176, alpha: 1)
                
            case .up:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                
            default:
                break
            }
            
        }, completion: nil)
    }
    
    // outsider function
    func animatedFromOutside() {
        self.bottonSheetAnimationManager()
        /*
        switch animationParams.callerType {
        case .outsider:
            
        case .sideButton:
            guard let direction = animationParams.direction else { return }
            self.closeButtonSheetView(direction: direction)
            break
        }*/
    }
    
    @objc fileprivate func donePressed(_ sender: UITapGestureRecognizer){
        print("\(#function)")
        self.doneButton.startAnimationCommon()
        self.bottonSheetAnimationManager()
        closureForSelectedCountryData?(self.countrySelectionViewModel.returnSelectedCountryData())
    }
    
}

// MARK: - PickerProtocols
extension CountrySelectionView: PickerProtocols {
    func getSelectedCountryInformation(countryData: CountryList) {
        print("\(#function)")
        
        self.cityPickerView.setCitidata(cityList: countryData.cities)
        self.countrySelectionViewModel.setSelectedCountry(country: countryData)
    }
    
    func getSelectedCity(city: String?) {
        print("\(#function) city : \(city)")
        self.countrySelectionViewModel.setSelectedCity(city: city)
    }
}

fileprivate extension Selector {
    static let animateView = #selector(CountrySelectionView.animateView)
    static let donePressed = #selector(CountrySelectionView.donePressed)
}
