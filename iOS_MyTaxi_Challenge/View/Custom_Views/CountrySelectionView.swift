//
//  CountrySelectionView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CountrySelectionView: BaseBottomSheetView {
    
    weak var delegate: ViewAnimationTrigger?
    private var direction: Direction = .up
    
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

}

// MARK: - major functions
extension CountrySelectionView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.6, green: 0.5607843137, blue: 0.6352941176, alpha: 1)
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        self.reArrangeTopBarViewConstraint()
        self.activationManager(active: false)
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
    
    // outsider functions
    func activationManager(active: Bool) {
        self.isUserInteractionEnabled = active
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
        
        switch direction {
        case .down:
            delegate?.triggerAnimation(direction: .up)
        case .up:
            delegate?.triggerAnimation(direction: .down)
        default:
            break
        }
        
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
    
}

fileprivate extension Selector {
    static let animateView = #selector(CountrySelectionView.animateView)
}
