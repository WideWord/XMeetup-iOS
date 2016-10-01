//
//  FadeTransitioning.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 01.10.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit

class FadeTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let to = transitionContext.viewController(forKey: .to)
            else { return }
        
        transitionContext.containerView.addSubview(to.view)
        to.view.alpha = 0
        to.view.frame = transitionContext.finalFrame(for: to)
        to.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2, animations: {
            to.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
}
