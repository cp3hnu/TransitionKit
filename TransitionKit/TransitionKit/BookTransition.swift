//
//  BookTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BookTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    private var animator = BookAnimatedTransitioning()
    private var interactiveAnimator = BookInteractiveTransition()
    public var isPresent = false {
        didSet {
            interactiveAnimator.isPresent = isPresent
        }
    }
    
    public init(duration: NSTimeInterval = 0.3) {
        super.init()
        animator.duration = duration
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
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            interactiveAnimator.wireToViewController(toVC)
        }
        animator.dismiss = operation == .Pop
        return animator
    }
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
}
