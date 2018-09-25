//
//  BookAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class BookAnimatedTransitioning: BaseAnimatedTransitioning {
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        containerView.layer.sublayerTransform = perspectiveTransform
        containerView.addSubview(toVC.view)
        let anchorPoint = CGPoint(x: 0, y: 0.5)
        var transform = CATransform3DMakeRotation(-(Double.pi/2).f, 0, 1, 0)
        transform = CATransform3DScale(transform, 1.2, 1.2, 1)
        if !dismiss {
            containerView.sendSubviewToBack(toVC.view)
            fromVC.view.setAnchorPoint(anchorPoint)
        } else {
            toVC.view.setAnchorPoint(anchorPoint)
            toVC.view.layer.transform = transform
        }
        
        UIView.animate(withDuration: duration, animations: {
            if !self.dismiss {
                fromVC.view.layer.transform = transform
            } else {
                toVC.view.layer.transform = CATransform3DIdentity
            }
            }, completion: { _ in
                fromVC.view.layer.transform = CATransform3DIdentity
                toVC.view.layer.transform = CATransform3DIdentity
                fromVC.view.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
                toVC.view.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
                containerView.layer.sublayerTransform = CATransform3DIdentity
                let cancelled = transitionContext.transitionWasCancelled
                if cancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!cancelled)
        })
    }
}
