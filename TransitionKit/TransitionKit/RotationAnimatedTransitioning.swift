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

    private var viewWidth: CGFloat = UIScreen.mainScreen().bounds.width
    
    private var fromTransform: CATransform3D  {
        let angle = dismiss ? -M_PI_2.f : M_PI_2.f
        let width = dismiss ? -viewWidth/2 : viewWidth/2
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, width, 0, 0)
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    private var toTransform: CATransform3D {
        let angle = dismiss ? -(M_PI.f + M_PI_2.f) : (M_PI.f + M_PI_2.f)
        let width = dismiss ? viewWidth/2 : -viewWidth/2
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, width, 0, 0)
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    private var finalTransform: CATransform3D  {
        let angle = dismiss ? -2 * M_PI.f: 2 * M_PI.f
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 0, 0)
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        viewWidth = fromVC.view.bounds.width
        containerView.layer.sublayerTransform = perspectiveTransform
        containerView.addSubview(toVC.view)
       
        let zeroAnchorPoint = CGPoint(x: 0, y: 0.5)
        let oneAnchorPoint = CGPoint(x: 1.0, y: 0.5)
        fromVC.view.setAnchorPoint(dismiss ? oneAnchorPoint : zeroAnchorPoint)
        toVC.view.setAnchorPoint(dismiss ? zeroAnchorPoint : oneAnchorPoint)
        
        toVC.view.layer.transform = toTransform
        toVC.view.alpha = 0.0
        shouldLayersRasterize([fromVC.view.layer, toVC.view.layer], shouldRasterize: true)
        
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                fromVC.view.layer.transform = self.fromTransform
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.0, animations: {
                fromVC.view.alpha = 0.0
                toVC.view.alpha = 1.0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                toVC.view.layer.transform = self.finalTransform
            })
            
            }, completion: { _ in
                fromVC.view.alpha = 1.0
                toVC.view.alpha = 1.0
                fromVC.view.layer.transform = CATransform3DIdentity
                toVC.view.layer.transform = CATransform3DIdentity
                self.shouldLayersRasterize([fromVC.view.layer, toVC.view.layer], shouldRasterize: false)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
