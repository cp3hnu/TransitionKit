//
//  BaseAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BaseAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    public var dismiss = false
    public var duration: NSTimeInterval = 0.3
    
    internal var perspectiveTransform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        return transform
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        animateTransition(transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        fatalError("animateTransition(transitionContext:) has not been implemented")
    }
}

public extension BaseAnimatedTransitioning {
    public func shouldLayersRasterize(layers: [CALayer], shouldRasterize: Bool) {
        layers.forEach {
            $0.shouldRasterize = shouldRasterize
            $0.rasterizationScale = UIScreen.mainScreen().scale
        }
    }
}
