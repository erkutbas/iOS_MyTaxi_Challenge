//
//  MapView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapView: BaseBottomSheetView {
    
    private var direction = Direction.up
    
    var mainScreenBounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        configureViewSettings()
    }

}

// MARK: - major functions
extension MapView {
    
    private func configureViewSettings() {
        self.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1)
        self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
        self.addGestures()
        self.reArrangeTopBarViewConstraint()
        self.activationManager(active: false)
    }
    
    private func reArrangeTopBarViewConstraint() {
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalToConstant: 100 + UIApplication.shared.returnBottomPadding()),
            ])
    }
    
    // outsider functions
    func activationManager(active: Bool) {
        self.isUserInteractionEnabled = active
    }
    
}

extension MapView: UIGestureRecognizerDelegate {
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGesture.delegate = self
        self.topBarView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch self.direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = .identity
                
            case .up:
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.direction = .down
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
                self.directionIcon.transform = CGAffineTransform(scaleX: 1, y: -1)
                
            default:
                break
            }
            
        }, completion: nil)
        
    }
    
    func animatedFromOutside(direction: Direction) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            switch direction {
            case .down:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height, width: self.frame.width, height: self.frame.height)
                self.direction = .up
                self.arrangeCornerRadius(radius: 0, maskCorner: .layerMinXMinYCorner)
            case .up:
                self.frame = CGRect(x: 0, y: self.mainScreenBounds.height - CONSTANT.VIEW_FRAME_VALUES.MAPVIEW_Y_COORDINATE - UIApplication.shared.returnBottomPadding(), width: self.frame.width, height: self.frame.height)
                self.direction = .down
                self.arrangeCornerRadius(radius: 80, maskCorner: .layerMinXMinYCorner)
                
            default:
                break
            }
            
        }, completion: nil)
    }
    
}

fileprivate extension Selector {
    static let animateView = #selector(MapView.animateView)
}

