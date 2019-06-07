//
//  CountrySelectionView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class CountrySelectionView: BaseView {
    
    weak var delegate: ViewAnimationTrigger?
    private var direction: Direction = .up

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        configureViewSettings()
    }

}

// MARK: - major functions
extension CountrySelectionView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.6, green: 0.5607843137, blue: 0.6352941176, alpha: 1)
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        
    }
    
    private func arrangeCornerRadius(radius: CGFloat, maskCorner: CACornerMask) {
        self.layer.maskedCorners = maskCorner
        self.layer.cornerRadius = radius
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension CountrySelectionView: UIGestureRecognizerDelegate {
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        
        let mainScreenBounds = UIScreen.main.bounds
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch self.direction {
            case .down:
                self.frame = CGRect(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE_ACTIVE, width: self.frame.width, height: self.frame.height)
                
            case .up:
                self.frame = CGRect(x: 0, y: mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.COUNTRY_SELECTION_VIEW_Y_COORDINATE, width: self.frame.width, height: self.frame.height)
            default:
                break
            }
            
        }, completion: nil)
        
    }
    
}

fileprivate extension Selector {
    static let animateView = #selector(CountrySelectionView.animateView)
}
