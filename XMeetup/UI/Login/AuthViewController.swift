//
//  AuthViewController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import EasyPeasy

class AuthViewController: UIViewController {
    
    override func loadView() {
        
        view = UIView()
        
        view.backgroundColor = AppColors.mainBackground
        
        let contentView = UIView()
        view.addSubview(contentView)
        contentView <- [Center(), Width(200)]
        
        
        let infoLabel = UILabel()
        contentView.addSubview(infoLabel)
        infoLabel.font = AppFonts.smallThin
        infoLabel.textColor = AppColors.main
        infoLabel.numberOfLines = 0
        infoLabel.text = "Войдите или зарегистрируйтесь чтобы создать событие"
        infoLabel.textAlignment = .center
        infoLabel.setContentCompressionResistancePriority(400, for: .horizontal)
        
        infoLabel <- [
            Left(), Right(), Top()
        ]
        
        let regButton = LoginButton(style: .filled)
        contentView.addSubview(regButton)
        regButton.setTitle("Создать аккаунт", for: .normal)
        regButton <- [Top(50).to(infoLabel), Left(), Right()]
        
        let loginButton = LoginButton(style: .light)
        contentView.addSubview(loginButton)
        loginButton.setTitle("Войти", for: .normal)
        loginButton <- [Left(), Right(), Top(15).to(regButton), Bottom()]
        
        
        
        
        
        _ = loginButton.rx.tap.bindNext { [weak self] in
            RootViewController.instance.useTransitioning(FadeTransitioning())
            self?.navigationController?.replaceCurrentController(with: LoginViewController(), animated: true)
        }
        
        _ = regButton.rx.tap.bindNext { [weak self] in
            RootViewController.instance.useTransitioning(FadeTransitioning())
            self?.navigationController?.replaceCurrentController(with: SignupViewController(), animated: true)
        }
        
    }
    
}

