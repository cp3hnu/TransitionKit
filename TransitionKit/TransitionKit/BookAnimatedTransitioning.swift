//
//  BookAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BookAnimatedTransitioning: BaseAnimatedTransitioning {
   
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
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        containerView.addSubview(toVC.view)
        let anchorPoint = CGPoint(x: 0, y: 0.5)
        if !dismiss {
            containerView.sendSubviewToBack(toVC.view)
            fromVC.view.setAnchorPoint(anchorPoint)
        } else {
            toVC.view.setAnchorPoint(anchorPoint)
        }
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            if !self.dismiss {
                fromVC.view.layer.transform = self.middleTransform
            } else {
                toVC.view.layer.transform = self.identityTransform
            }
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
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
