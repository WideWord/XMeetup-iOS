//
//  LoginButton.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import EasyPeasy

class LoginButton: UIButton {
    
    struct Style {
        var backgroundNormalColor: UIColor
        var backgroundHighlightedColor: UIColor
        var backgroundDisabledColor: UIColor
        
        var borderNormalColor: UIColor
        var borderDisabledColor: UIColor
        
        var titleHighlightedColor: UIColor
        
        static let filled = Style(
            backgroundNormalColor: AppColors.main,
            backgroundHighlightedColor: .clear,
            backgroundDisabledColor: AppColors.main.darkerColor(0.2),
            borderNormalColor: AppColors.main,
            borderDisabledColor: AppColors.main.darkerColor(0.2),
            titleHighlightedColor: .white
        )
        
        static let light = Style(
            backgroundNormalColor: .clear,
            backgroundHighlightedColor: .clear,
            backgroundDisabledColor: .clear,
            borderNormalColor: AppColors.main,
            borderDisabledColor: AppColors.main.darkerColor(0.2),
            titleHighlightedColor: .clear
        )
    }
    
    let style: Style
    
    private let activityIndicator = UIActivityIndicatorView()
    
    init(style: Style) {
        self.style = style
        super.init(frame: CGRect.null)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1.0 / UIScreen.main.scale
        layer.borderColor = style.borderNormalColor.cgColor
        
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.darkerColor(0.4), for: .disabled)
        setTitleColor(style.titleHighlightedColor, for: .highlighted)
        
        self <- Height(40)
        
        isEnabled = true
        isHighlighted = false
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        titleLabel?.font = AppFonts.thin
        
        addSubview(activityIndicator)
        activityIndicator.isHidden = true
        activityIndicator <- Center()
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateView()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateView()
        }
    }
    
    var isActivityIndicatorVisible: Bool = false {
        didSet {
            updateView()
            if isActivityIndicatorVisible {
                activityIndicator.startAnimating()
                setTitleColor(.clear, for: .normal)
                setTitleColor(.clear, for: .disabled)
                setTitleColor(.clear, for: .highlighted)
            } else {
                activityIndicator.stopAnimating()
                setTitleColor(.white, for: .normal)
                setTitleColor(UIColor.white.darkerColor(0.4), for: .disabled)
                setTitleColor(style.titleHighlightedColor, for: .highlighted)
            }
        }
    }
    
    private func updateView() {
        if isActivityIndicatorVisible {
            layer.borderColor = style.borderNormalColor.cgColor
            backgroundColor = style.backgroundHighlightedColor
        } else if isEnabled {
            layer.borderColor = style.borderNormalColor.cgColor
            if isHighlighted {
                backgroundColor = style.backgroundHighlightedColor
            } else {
                UIView.animate(withDuration: 0.4) {
                    self.backgroundColor = self.style.backgroundNormalColor
                }
            }
        } else {
            layer.borderColor = style.borderDisabledColor.cgColor
            self.backgroundColor = style.backgroundDisabledColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
