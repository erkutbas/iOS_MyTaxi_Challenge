//
//  SideButtonView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/10/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class SideButtonView: BaseBottomSheetView {
    
    private var direction = Direction.right
    var mainScreenBounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    weak var delegate: ViewControllerPresentationProtocol?

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        self.changeViewConfigurations()
        self.changeIconImage()
        self.addGestures()
    }
    
    override func reArrangeViewConstraints() {
        super.reArrangeViewConstraints()
        self.changeStackViewCostraints()
        self.changeMainStackViewPrompts()
        self.reArrangeTopBarViewConstraint()
    }

}

// MARK: - major functions
extension SideButtonView {
    
    private func changeViewConfigurations() {
        self.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.4980392157, blue: 0.6509803922, alpha: 1)
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    private func changeIconImage() {
        guard let image = UIImage(named: "direction2") else { return }
        self.directionIcon.image = image
        self.directionIcon.contentMode = .center
    }
    
    private func changeStackViewCostraints() {
        print("Yarro ooooooo ")
        self.mainStackViewLeadingConstraint.constant = 10
    }
    
    private func changeMainStackViewPrompts() {
        self.mainSubject.text = LocalizedConstants.TitlePrompts.listView
        self.mainSubject.font = UIFont(name: "Avenir-Medium", size: 16)
        self.detailedInformation.text = nil
    }
    
    private func reArrangeTopBarViewConstraint() {
        NSLayoutConstraint.activate([
            topBarView.heightAnchor.constraint(equalToConstant: self.frame.height),
            ])
    }
    
    // outsider
    func outsideAnimationManager(direction: Direction) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            switch direction {
            case .left:
                self.frame = CGRect(x: self.mainScreenBounds.width - (UIScreen.main.bounds.width / 3) , y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
                self.arrangeCornerRadius(radius: 25, maskCorner: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
                self.directionIcon.transform = .identity
                
            case .right:
                self.frame = CGRect(x: self.mainScreenBounds.width, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
                self.arrangeCornerRadius(radius: 0, maskCorner: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
                self.directionIcon.transform = CGAffineTransform(scaleX: -1, y: 1)
                
            default:
                break
            }
            
        }, completion: nil)
    }

    // outsider functions
    func sideButtonActivationManager(active: Bool) {
        DispatchQueue.main.async {
            
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                if active {
                    self.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.4980392157, blue: 0.6509803922, alpha: 1)
                } else {
                    self.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.1882352941, blue: 0.3137254902, alpha: 1)
                }
            }, completion: { (finish) in
                self.isUserInteractionEnabled = active
            })
            
            if active {
                
            }
            
            
        }
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension SideButtonView: UIGestureRecognizerDelegate {
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.tapTriggered)
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func tapTriggered(_ sender: UITapGestureRecognizer) {
        print("\(#function)")
        self.startAnimationCommon()
        self.delegate?.pushViewController()
        
    }
    
    @objc fileprivate func slideTriggered(_ sender: UITapGestureRecognizer) {
        
    }
    
}

fileprivate extension Selector {
    static let slideTriggered = #selector(SideButtonView.slideTriggered)
    static let tapTriggered = #selector(SideButtonView.tapTriggered)
}
