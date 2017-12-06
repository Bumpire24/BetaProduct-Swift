//
//  BetaProductTransitionAnimator.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/6/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class BetaProductTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewControllerNav = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
