//
//  RootViewController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import EasyPeasy

class RootViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    private(set) static var instance: RootViewController!
    
    let rootNavigationController = UINavigationController()
    
    override func loadView() {
        RootViewController.instance = self
        
        view = UIView()
        view.backgroundColor = AppColors.grayBackground
        
        addChildViewController(rootNavigationController)
        view.addSubview(rootNavigationController.view)
        rootNavigationController.view <- Edges()
        rootNavigationController.didMove(toParentViewController: self)
        
        rootNavigationController.navigationBar.barTintColor = AppColors.mainBackground
        rootNavigationController.navigationBar.barStyle = .black
        rootNavigationController.navigationBar.tintColor = .white
        rootNavigationController.navigationBar.isTranslucent = false
        
        rootNavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootNavigationController.navigationBar.shadowImage = UIImage()
        rootNavigationController.navigationBar.backgroundColor = AppColors.mainBackground
        
        rootNavigationController.delegate = self
        rootNavigationController.interactivePopGestureRecognizer?.delegate = self
        
        rootNavigationController.viewControllers = [FeedViewController()]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var nextAnimatedTransitioning: UIViewControllerAnimatedTransitioning?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let res = nextAnimatedTransitioning
        nextAnimatedTransitioning = nil
        return res
    }
    
    func useTransitioning(_ transitioning: UIViewControllerAnimatedTransitioning) {
        nextAnimatedTransitioning = transitioning
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return rootNavigationController.viewControllers.count > 1
    }
    
}
