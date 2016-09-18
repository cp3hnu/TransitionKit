//
//  FlipTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/9.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

open class FlipTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    fileprivate var animator = FlipAnimatedTransitioning()
    
    public init(duration: TimeInterval = 0.3) {
        super.init()
        animator.duration = duration
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = false
        return animator
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = true
        return animator
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.dismiss = operation == .pop
        return animator
    }
}
