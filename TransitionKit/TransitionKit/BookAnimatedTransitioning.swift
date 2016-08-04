//
//  BookAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BookAnimatedTransitioning: BaseAnimatedTransitioning {
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    private var identityTransform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        return transform
    }
    
    private var middleTransform: CATransform3D  {
        var transform = CATransform3DMakeRotation(-M_PI_2.f, 0, 1, 0)
        transform.m34 = 1.0/1000
        return transform
    }
    
    private var fromAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: identityTransform)
        animation.toValue = NSValue(CATransform3D: middleTransform)
        animation.duration = transitionDuration(transitionContext)
        animation.delegate = self
        return animation
    }
    
    private var toAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: middleTransform)
        animation.toValue = NSValue(CATransform3D: identityTransform)
        animation.duration = transitionDuration(transitionContext)
        animation.removedOnCompletion = true
        animation.delegate = self
        return animation
    }
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(toVC.view)
        
        if !dismiss {
            containerView.sendSubviewToBack(toVC.view)
            
            fromVC.view.layer.zPosition = 1000
            fromVC.view.setAnchorPoint(CGPoint(x: 0, y: 0.5))
            fromVC.view.layer.transform = middleTransform
            fromVC.view.layer.addAnimation(fromAnimation, forKey: "fromVC")
        } else {
            toVC.view.layer.zPosition = 1000
            toVC.view.setAnchorPoint(CGPoint(x: 0, y: 0.5))
            toVC.view.layer.transform = identityTransform
            toVC.view.layer.addAnimation(toAnimation, forKey: "toVC")
        }
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let cancelled = transitionContext?.transitionWasCancelled() ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}

extension CGPoint {
    mutating func translate(dx: CGFloat, _ dy: CGFloat) {
        x -= dx
        y -= dy
    }
}

extension UIView {
    func setAnchorPoint(point: CGPoint) {
        let oldOrigin = frame.origin
        layer.anchorPoint = point
        let newOrigin = frame.origin
        
        let translateX = newOrigin.x - oldOrigin.x
        let translateY = newOrigin.y - oldOrigin.y
    
        center.translate(translateX, translateY)
    }
}
