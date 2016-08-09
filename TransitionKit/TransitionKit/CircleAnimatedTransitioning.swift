//
//  CircleAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class CircleAnimatedTransitioning: BaseAnimatedTransitioning {
 
    var clickedPoint = CGPoint.zero
    private weak var transitionContext: UIViewControllerContextTransitioning?
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        self.transitionContext = transitionContext
        containerView.addSubview(toVC.view)
        
        let point = clickedPoint
        let maskInitialPath = UIBezierPath(arcCenter: point, radius: 2, startAngle: 0, endAngle: 2 * M_PI.f, clockwise: true)
        let extremePoint = CGPoint(x: max(CGRectGetWidth(fromVC.view.bounds) - point.x, point.x), y: max(CGRectGetHeight(fromVC.view.bounds) - point.y, point.y))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let maskFinaLPath = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: 2 * M_PI.f, clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskFinaLPath.CGPath
        toVC.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = maskInitialPath.CGPath
        animation.toValue = maskFinaLPath.CGPath
        animation.duration = duration
        animation.delegate = self
        maskLayer.addAnimation(animation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let toVC = transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)
        toVC?.view.layer.mask = nil
        let cancelled = transitionContext?.transitionWasCancelled() ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}
