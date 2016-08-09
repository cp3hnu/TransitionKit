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
        let transform = CATransform3DMakeRotation(-M_PI_2.f, 0, 1, 0)
        if !dismiss {
            containerView.sendSubviewToBack(toVC.view)
            fromVC.view.setAnchorPoint(anchorPoint)
        } else {
            toVC.view.setAnchorPoint(anchorPoint)
            toVC.view.layer.transform = transform
        }
        
        UIView.animateWithDuration(duration, animations: {
            if !self.dismiss {
                fromVC.view.layer.transform = transform
            } else {
                toVC.view.layer.transform = CATransform3DIdentity
            }
            }, completion: { _ in
                if !self.dismiss {
                    fromVC.view.layer.transform = CATransform3DIdentity
                }
                
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
