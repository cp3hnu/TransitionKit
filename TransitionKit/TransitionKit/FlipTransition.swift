//
//  FlipTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/9.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class FlipTransition: NSObject, UINavigationControllerDelegate {
    private var animator = FlipAnimatedTransitioning()
    
    public init(duration: NSTimeInterval = 0.3) {
        super.init()
        animator.duration = duration
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = false
        return animator
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = true
        return animator
    }
    
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = operation == .Pop
        return animator
    }
}
