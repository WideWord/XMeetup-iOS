//
//  NavigationController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func replaceCurrentController(with controller: UIViewController, animated: Bool) {
        var vc = viewControllers
        vc.removeLast()
        vc.append(controller)
        setViewControllers(vc, animated: animated)
    }
    
}
