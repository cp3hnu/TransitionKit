//
//  BookTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

open class BookTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    fileprivate var animator = BookAnimatedTransitioning()
    fileprivate var interactiveAnimator = BookInteractiveTransition()
    open var isPresent = false {
        didSet {
            interactiveAnimator.isPresent = isPresent
        }
    }
    
    public init(duration: TimeInterval = 0.3) {
        super.init()
        animator.duration = duration
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveAnimator.wireToViewController(presented)
        animator.dismiss = false
        return animator
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = true
        return animator
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interactiveAnimator.wireToViewController(toVC)
        }
        animator.dismiss = operation == .pop
        return animator
    }
    
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
}
