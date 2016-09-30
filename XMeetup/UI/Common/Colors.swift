//
//  Colors.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit



extension UIColor {
    
    convenience init(hex: UInt64) {
        let red = (hex >> 16) & 255
        let green = (hex >> 8) & 255
        let blue = hex & 255
        self.init(red: CGFloat(red) / CGFloat(255),
                  green: CGFloat(green) / CGFloat(255),
                  blue: CGFloat(blue) / CGFloat(255),
                  alpha: 1)
    }
    
}

struct AppColors {
    
    static let mainBackground = UIColor(hex: 0x2E2D4B)
    static let main = UIColor(hex: 0x84A7DC)
    
    static let grayBackground = UIColor(hex: 0xA5A5A7)
    
}
