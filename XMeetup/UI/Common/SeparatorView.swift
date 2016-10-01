//
//  SeparatorView.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame.size.height = 1.0 / UIScreen.main.scale
    }
    
}
