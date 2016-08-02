//
//  SemiModelTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

public final class SemiModelTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    private var animator: SemiModelAnimatedTransitioning!
    private var interactiveAnimator: SemiModelInteractiveTransition!
    
    public init(distance: CGFloat = 100, duration: NSTimeInterval = 0.3) {
        animator = SemiModelAnimatedTransitioning(distance: distance)
        animator.duration = duration
        interactiveAnimator = SemiModelInteractiveTransition(distance: distance)
        super.init()
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveAnimator.wireToViewController(presented)
        animator.dismiss = false
        return animator
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = true
        return animator
    }
    
    public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? self.interactiveAnimator : nil
    }
    
    public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return SemiModelPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
}