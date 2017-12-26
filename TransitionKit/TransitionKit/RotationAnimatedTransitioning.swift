//
//  RotationAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

private let AnimationKey = "animationID"

class RotationAnimatedTransitioning: BaseAnimatedTransitioning {

    fileprivate var fromTransform: CATransform3D  {
        let angle = dismiss ? -(Double.pi/2).f : (Double.pi/2).f
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    fileprivate var toTransform: CATransform3D {
        let angle = dismiss ? (Double.pi/2).f : -(Double.pi/2).f
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        containerView.addSubview(toVC.view)
        toVC.view.layer.transform = toTransform
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                fromVC.view.layer.transform = self.fromTransform
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                toVC.view.layer.transform = CATransform3DIdentity
            })
            
            }, completion: { _ in
                fromVC.view.layer.transform = CATransform3DIdentity
                toVC.view.layer.transform = CATransform3DIdentity
                containerView.layer.sublayerTransform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
