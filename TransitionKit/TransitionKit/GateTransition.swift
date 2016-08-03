//
//  GateTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

public class GateTransition: NSObject, UINavigationControllerDelegate {
    
    private var animator: GateAnimatedTransitioning!
    private var interactiveAnimator: GateInteractiveTransition!
    
    public init(sawtoothCount: Int = 1, sawtoothDistance: CGFloat = 0, duration: NSTimeInterval = 0.3) {
        animator = GateAnimatedTransitioning(sawtoothCount: sawtoothCount, sawtoothDistance: sawtoothDistance)
        animator.duration = duration
        interactiveAnimator = GateInteractiveTransition()
        super.init()
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            interactiveAnimator.wireToViewController(toVC)
        }
        animator.dismiss = (operation != .Push)
        return animator
    }
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveAnimator.interactionInProgress ? interactiveAnimator : nil
    }
}