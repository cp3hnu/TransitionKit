//
//  RotationAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

private let AnimationKey = "animationID"

public class RotationAnimatedTransitioning: BaseAnimatedTransitioning {
    
    private var identityTransform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/2000
        return transform
    }
    
    private var middleTransform: CATransform3D  {
        let angle = dismiss ? -M_PI_2.f : M_PI_2.f
        var transform = CATransform3DMakeRotation(angle, 0, 1, 0)
        transform.m34 = -1.0/2000
        return transform
    }
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        toVC.view.layer.transform = middleTransform
        
        let duration = transitionDuration(transitionContext)
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                fromVC.view.layer.transform = self.middleTransform
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                toVC.view.layer.transform = self.identityTransform
            })
            
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
