//
//  SignupViewController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import EasyPeasy

class SignupViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        
        navigationItem.title = "Регистрация"
        
        view = UIView()
        
        view.backgroundColor = AppColors.mainBackground
        
        let avaliableView = UIView()
        view.addSubview(avaliableView)
        avaliableView <- [
            Left(),
            Right(),
            Top().to(topLayoutGuide),
            Bottom().to(keyboardLayoutGuide)
        ]
        
        let inputBlock = UIView()
        avaliableView.addSubview(inputBlock)
        avaliableView.layoutMargins = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        inputBlock <- [
            Center(),
            Width(<=360)
        ]
        inputBlock <- [LeftMargin(), RightMargin()].with(.mediumPriority)
        
        
        let emailField = LoginTextField()
        inputBlock.addSubview(emailField)
        if #available(iOS 10.0, *) {
            emailField.textContentType = .emailAddress
        }
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.placeholder = "email"
        emailField.keyboardAppearance = .dark
        
        emailField <- [Left(), Right(), Top()]
        
        let passwordField = LoginTextField()
        inputBlock.addSubview(passwordField)
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "••••••"
        passwordField.keyboardAppearance = .dark
        
        passwordField <- [Left(), Right(), Top(10).to(emailField)]
        
        let loginButton = LoginButton(style: .filled)
        inputBlock.addSubview(loginButton)
        loginButton.setTitle("Создать аккаунт", for: .normal)
        loginButton <- [
            CenterX(),
            Width(200),
            Top(20).to(passwordField),
        ]
        
        Observable.combineLatest(
            emailField.rx.text.map { !$0.isEmpty },
            passwordField.rx.text.map { $0.characters.count >= 6 },
            resultSelector: { $0 && $1 }
        ).bindTo(loginButton.rx.enabled).addDisposableTo(disposeBag)
        
        
        let alreadyHaveAccount = UIButton()
        inputBlock.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.titleLabel?.font = AppFonts.smallThin
        alreadyHaveAccount.setTitleColor(.white, for: .normal)
        alreadyHaveAccount.setTitle("Уже регистрировались?", for: .normal)
        alreadyHaveAccount <- [Top().to(loginButton), CenterX(), Bottom(), Height(40)]
        alreadyHaveAccount.rx.tap.bindNext { [weak self] in
            RootViewController.instance.useTransitioning(FadeTransitioning())
            self?.navigationController?.replaceCurrentController(with: LoginViewController(), animated: true)
        }.addDisposableTo(disposeBag)
        
        
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.rx.event.asVoid().bindNext { [weak self] in
            self?.view.endEditing(true)
        }.addDisposableTo(disposeBag)
        view.addGestureRecognizer(tapRecognizer)
        
        
        _ = loginButton.rx.tap.bindNext {
            loginButton.isActivityIndicatorVisible = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
}
