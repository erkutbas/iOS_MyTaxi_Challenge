//
//  RefreshingView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/7/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

import NVActivityIndicatorView

class RefreshingView: BaseView {
    
    lazy var activityAnimation: NVActivityIndicatorView = {
        let temp = NVActivityIndicatorView(frame: .zero, type: .orbit, color: .white, padding: 0)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func prepareViewConfigurations() {
        viewConfigurations()
        addAnimationView()
    }
    
    private func viewConfigurations() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private func addAnimationView() {
        self.addSubview(activityAnimation)
        
        NSLayoutConstraint.activate([
            
            activityAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityAnimation.heightAnchor.constraint(equalToConstant: 80),
            activityAnimation.widthAnchor.constraint(equalToConstant: 80),
            
            ])
        
        activityAnimation.startAnimating()
        
    }
    
    // outsider function
    func activationManager(active : Bool) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                if active {
                    self.alpha = 1
                } else {
                    self.alpha = 0
                }
            })
        }
    }
    
}

