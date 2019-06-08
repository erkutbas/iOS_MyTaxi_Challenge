//
//  UIApplication+Extension.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

extension UIApplication {
    func returnBottomPadding() -> CGFloat {
        var bottomPadding: CGFloat = 0
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = (window?.safeAreaInsets.bottom)!
        }
        
        return bottomPadding
    }
}
