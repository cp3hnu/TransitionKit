//
//  CircleAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class CircleAnimatedTransitioning: BaseAnimatedTransitioning {
 
    public var clickedPoint = CGPoint.zero
    private weak var transitionContext: UIViewControllerContextTransitioning?
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        containerView.addSubview(toVC.view)
        
        let point = clickedPoint
        let circleMaskPathInitial = UIBezierPath(arcCenter: point, radius: 2, startAngle: 0, endAngle: 2 * M_PI.f, clockwise: true)
        let extremePoint = CGPoint(x: max(CGRectGetWidth(fromVC.view.bounds) - point.x, point.x), y: max(CGRectGetHeight(fromVC.view.bounds) - point.y, point.y))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: 2 * M_PI.f, clockwise: true)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toVC.view.layer.mask = maskLayer
        
        let duration = transitionDuration(transitionContext)
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = circleMaskPathInitial.CGPath
        animation.toValue = circleMaskPathFinal.CGPath
        animation.duration = duration
        animation.delegate = self
        maskLayer.addAnimation(animation, forKey: "path")
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let toVC = transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)
        toVC?.view.layer.mask = nil
        let cancelled = transitionContext?.transitionWasCancelled() ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}
