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
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        containerView.addSubview(toVC.view)
        
        let point = clickedPoint
        let maskInitialPath = UIBezierPath(arcCenter: point, radius: 2, startAngle: 0, endAngle: 2 * Double.pi.f, clockwise: true)
        let extremePoint = CGPoint(x: max(fromVC.view.bounds.width - point.x, point.x), y: max(fromVC.view.bounds.height - point.y, point.y))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let maskFinaLPath = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: 2 * Double.pi.f, clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskFinaLPath.cgPath
        toVC.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = maskInitialPath.cgPath
        animation.toValue = maskFinaLPath.cgPath
        animation.duration = duration
        animation.delegate = self
        maskLayer.add(animation, forKey: "path")
    }
}

extension CircleAnimatedTransitioning: CAAnimationDelegate {
     public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let toVC = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)
        toVC?.view.layer.mask = nil
        let cancelled = transitionContext?.transitionWasCancelled ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}
