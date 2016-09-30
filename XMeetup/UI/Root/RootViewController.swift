//
//  RootViewController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import EasyPeasy

class RootViewController: UIViewController {
    
    let rootNavigationController = UINavigationController()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = AppColors.grayBackground
        
        addChildViewController(rootNavigationController)
        view.addSubview(rootNavigationController.view)
        rootNavigationController.view <- Edges()
        rootNavigationController.didMove(toParentViewController: self)
        
        rootNavigationController.navigationBar.barTintColor = AppColors.mainBackground
        rootNavigationController.navigationBar.barStyle = .black
        rootNavigationController.navigationBar.tintColor = .white
        

        
        rootNavigationController.viewControllers = [FeedViewController()]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
