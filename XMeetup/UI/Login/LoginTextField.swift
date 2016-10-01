//
//  LoginTextField.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import EasyPeasy

class LoginTextField: UITextField {
    
    private let downLine = SeparatorView()
    
    init() {
        super.init(frame: CGRect.null)
        
        addSubview(downLine)
        downLine.backgroundColor = AppColors.main
        tintColor = AppColors.main
        textColor = AppColors.main
        font = AppFonts.thin
        textAlignment = .center
        
        downLine <- [
            Bottom(),
            Height(1),
            Left(),
            Right()
        ]
        
        self <- Height(40)
    }
    
    override var placeholder: String? {
        set {
            attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: [NSForegroundColorAttributeName: AppColors.main.darkerColor(0.5)])
        }
        get {
            return attributedPlaceholder?.string
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
