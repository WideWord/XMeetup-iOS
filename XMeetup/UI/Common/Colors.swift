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
    
    func colorWithBrightnessFactor(_ factor: CGFloat) -> UIColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return self
        }
    }
    
    func lighterColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 + percent))
    }
    
    func darkerColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 - percent))
    }
    
}

struct AppColors {
    
    static let mainBackground = UIColor(hex: 0x2E2D4B)
    static let main = UIColor(hex: 0x84A7DC)
    
    static let grayBackground = UIColor(hex: 0xA5A5A7)
    
}
