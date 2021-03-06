//
//  SemiModelAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class SemiModelAnimatedTransitioning: BaseAnimatedTransitioning {
    fileprivate let distanceFromTop: CGFloat
    
    init(distanceFromTop: CGFloat = 100) {
        self.distanceFromTop = distanceFromTop
        super.init()
    }
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        var t1 = CATransform3DIdentity
        t1.m34 = -1.0/900
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        t1 = CATransform3DRotate(t1, 15.0*(Double.pi).f/180.0, 1, 0, 0)
        
        let scale: CGFloat = 0.8
        var t2 = CATransform3DIdentity
        t2.m34 = t1.m34
        t2 = CATransform3DTranslate(t2, 0, -0.07 * fromVC.view.frame.size.height, 0)
        t2 = CATransform3DScale(t2, scale, scale, 1)
        
        if !dismiss {
            let finalFrame = transitionContext.finalFrame(for: toVC)
            let size = UIScreen.main.bounds.size
            let initialFrame = finalFrame.offsetBy(dx: 0, dy: size.height)
            toVC.view.frame = initialFrame
            containerView.addSubview(toVC.view)
            fromVC.view.layer.zPosition = -1000
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions(rawValue: 0), animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    fromVC.view.layer.transform = t1
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    fromVC.view.layer.transform = t2
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    toVC.view.frame = finalFrame.offsetBy(dx: 0, dy: self.distanceFromTop)
                })
                
                }, completion: { _ in
                    fromVC.view.layer.zPosition = 0
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            toVC.view.layer.transform = CATransform3DIdentity
            toVC.view.alpha = 0
            let snapshotView = toVC.view.snapshotView(afterScreenUpdates: false)!
            containerView.addSubview(snapshotView)
            containerView.sendSubviewToBack(snapshotView)
            snapshotView.layer.zPosition = -1000
            snapshotView.frame = toVC.view.frame
            snapshotView.layer.transform = t2
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions(rawValue: 0), animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    snapshotView.layer.transform = t1
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    snapshotView.layer.transform = CATransform3DIdentity
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    fromVC.view.frame = fromVC.view.frame.offsetBy(dx: 0, dy: fromVC.view.frame.height - self.distanceFromTop)
                })
                
                }, completion: { _ in
                    snapshotView.removeFromSuperview()
                    toVC.view.alpha = 1.0
                    if transitionContext.transitionWasCancelled {
                        toVC.view.layer.transform = t2
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
