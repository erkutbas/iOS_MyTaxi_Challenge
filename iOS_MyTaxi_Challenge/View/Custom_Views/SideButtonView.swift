//
//  SideButtonView.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/10/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class SideButtonView: BaseBottomSheetView {

    override func prepareViewConfigurations() {
        super.prepareViewConfigurations()
        self.changeViewConfigurations()
        self.changeIconImage()
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
    
}
