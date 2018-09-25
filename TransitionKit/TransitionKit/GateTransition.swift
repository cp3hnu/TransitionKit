//
//  GateTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

open class GateTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    fileprivate var animator: GateAnimatedTransitioning!
    fileprivate var interactiveAnimator: GateInteractiveTransition!
    open var isPresent = false {
        didSet {
            interactiveAnimator.isPresent = isPresent
        }
    }
    
    public init(sawtoothCount: Int = 1, sawtoothDistance: CGFloat = 0, duration: TimeInterval = 0.3) {
        animator = GateAnimatedTransitioning(sawtoothCount: sawtoothCount, sawtoothDistance: sawtoothDistance)
        animator.duration = duration
        interactiveAnimator = GateInteractiveTransition()
        super.init()
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
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interactiveAnimator.wireToViewController(toVC)
        }
        animator.dismiss = (operation != .push)
        return animator
    }
    
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
}
