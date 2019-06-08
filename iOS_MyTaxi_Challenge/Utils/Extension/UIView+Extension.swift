//
//  UIView+Extension.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

extension UIView {
    
    public func startAnimationCommon() {
        
        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // buton view kucultulur
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.50),  // yay sonme orani, arttikca yanip sonme artar
            initialSpringVelocity: CGFloat(6.0),    // yay hizi, arttikca hizlanir
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                
                self.transform = CGAffineTransform.identity
                
                
        })
        self.layoutIfNeeded()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func arrangeCornerRadius(radius: CGFloat, maskCorner: CACornerMask) {
        self.layer.maskedCorners = maskCorner
        self.layer.cornerRadius = radius
    }
    
}
