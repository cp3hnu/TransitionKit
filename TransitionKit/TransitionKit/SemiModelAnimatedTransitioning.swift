//
//  SemiModelAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class SemiModelAnimatedTransitioning: BaseAnimatedTransitioning {
    private let distanceFromTop: CGFloat
    
    public init(distance: CGFloat = 100) {
        distanceFromTop = distance
        super.init()
    }
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        let duration = transitionDuration(transitionContext)
        
        var t1 = CATransform3DIdentity
        t1.m34 = -1.0/900
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        t1 = CATransform3DRotate(t1, 15.0*M_PI.f/180.0, 1, 0, 0)
        
        let scale: CGFloat = 0.8
        var t2 = CATransform3DIdentity
        t2.m34 = t1.m34
        t2 = CATransform3DTranslate(t2, 0, -0.07 * fromVC.view.frame.size.height, 0)
        t2 = CATransform3DScale(t2, scale, scale, 1)
        
        if !dismiss {
            let finalFrame = transitionContext.finalFrameForViewController(toVC)
            let size = UIScreen.mainScreen().bounds.size
            let initialFrame = CGRectOffset(finalFrame, 0, size.height)
            toVC.view.frame = initialFrame
            containerView.addSubview(toVC.view)
            fromVC.view.layer.zPosition = -1000
            UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                    fromVC.view.layer.transform = t1
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                    fromVC.view.layer.transform = t2
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                    toVC.view.frame = CGRectOffset(finalFrame, 0, self.distanceFromTop)
                })
                
                }, completion: { _ in
                    fromVC.view.layer.zPosition = 0
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        } else {
            toVC.view.layer.transform = CATransform3DIdentity
            toVC.view.alpha = 0
            let snapshotView = toVC.view.snapshotViewAfterScreenUpdates(false)
            containerView.addSubview(snapshotView)
            containerView.sendSubviewToBack(snapshotView)
            snapshotView.layer.zPosition = -1000
            snapshotView.frame = toVC.view.frame
            snapshotView.layer.transform = t2
            UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                    snapshotView.layer.transform = t1
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                    snapshotView.layer.transform = CATransform3DIdentity
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                    fromVC.view.frame = CGRectOffset(fromVC.view.frame, 0, fromVC.view.frame.height - self.distanceFromTop)
                })
                
                }, completion: { _ in
                    snapshotView.removeFromSuperview()
                    toVC.view.alpha = 1.0
                    if transitionContext.transitionWasCancelled() {
                        toVC.view.layer.transform = t2
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
}
