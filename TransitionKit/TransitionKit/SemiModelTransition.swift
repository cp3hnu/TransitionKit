//
//  SemiModelTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

public final class SemiModelTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    fileprivate var animator: SemiModelAnimatedTransitioning!
    fileprivate var interactiveAnimator: SemiModelInteractiveTransition!
    
    public init(distanceFromTop: CGFloat = 100, duration: TimeInterval = 0.3) {
        animator = SemiModelAnimatedTransitioning(distanceFromTop: distanceFromTop)
        animator.duration = duration
        interactiveAnimator = SemiModelInteractiveTransition(distanceFromTop: distanceFromTop)
        super.init()
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveAnimator.wireToViewController(presented)
        animator.dismiss = false
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = true
        return animator
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? self.interactiveAnimator : nil
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SemiModelPresentationController(presentedViewController: presented, presenting: presenting ?? source)
    }
    
}
