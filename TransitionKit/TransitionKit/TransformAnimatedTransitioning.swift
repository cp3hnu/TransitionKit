//
//  TransformAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

private let AnimationKey = "animationID"

public class TransformAnimatedTransitioning: BaseAnimatedTransitioning {
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    private var identityTransform: CATransform3D {
        var transform = CATransform3DIdentity
        //transform.m34 = -1.0/900
        return transform
    }
    
    private var middleTransform: CATransform3D  {
        let angle = dismiss ? -M_PI_2.f : M_PI_2.f
        var transform = CATransform3DMakeRotation(angle, 0, 1, 0)
        //transform.m34 = -1.0/900
        return transform
    }
    
    private var fromAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.setValue("from", forKey: AnimationKey)
        animation.fromValue = NSValue(CATransform3D: identityTransform)
        animation.toValue = NSValue(CATransform3D: middleTransform)
        animation.duration = transitionDuration(transitionContext)/2
        animation.delegate = self
        return animation
    }
    
    private var toAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.setValue("to", forKey: AnimationKey)
        animation.fromValue = NSValue(CATransform3D: middleTransform)
        animation.toValue = NSValue(CATransform3D: identityTransform)
        animation.duration = transitionDuration(transitionContext)/2
        animation.delegate = self
        return animation
    }
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        toVC.view.layer.transform = middleTransform
        
        fromVC.view.layer.transform = middleTransform
        fromVC.view.layer.addAnimation(fromAnimation, forKey: "fromVC")
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if anim.valueForKey(AnimationKey) as? String == "from" {
            let toVC = transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)
            toVC?.view.layer.transform = identityTransform
            toVC?.view.layer.addAnimation(toAnimation, forKey: "toVC")
        } else {
            let fromVC = transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)
            fromVC?.view.layer.transform = identityTransform
            let cancelled = transitionContext?.transitionWasCancelled() ?? false
            transitionContext?.completeTransition(!cancelled)
        }
    }
}
