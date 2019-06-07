//
//  MapView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapView: BaseView {

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        
        //self.roundCorners(corners: [.topLeft], radius: 80.0)
        self.layer.cornerRadius = 80
        self.layer.maskedCorners = [.layerMinXMinYCorner]
        
        self.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.07450980392, blue: 0.1960784314, alpha: 1)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector.animateView)
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    }

}

extension MapView: UIGestureRecognizerDelegate {
    
    func animateSlideMenu(active: Bool) {
        
        UIView.animate(withDuration: 5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.layer.cornerRadius = 0
            //self.layer.maskedCorners = [.layerMinXMinYCorner]
            
            if active {
                //self.shadowMenu.alpha = 1
                
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                
            } else {
                //self.shadowMenu.alpha = 0
                
                self.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - 100, width: self.frame.width, height: self.frame.height)
            }
            
        }, completion: nil)
        
    }
    
    @objc fileprivate func animateView(_ sender: UITapGestureRecognizer) {
        animateSlideMenu(active: true)
    }
    
}

fileprivate extension Selector {
    static let animateView = #selector(MapView.animateView)
}
