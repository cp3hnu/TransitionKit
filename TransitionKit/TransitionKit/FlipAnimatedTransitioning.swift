//
//  FlipAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/9.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class FlipAnimatedTransitioning: BaseAnimatedTransitioning {
    
    private weak var transitionContext: UIViewControllerContextTransitioning?
    private var viewWidth: CGFloat = UIScreen.mainScreen().bounds.width
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        self.transitionContext = transitionContext
        
        let fromView = fromVC.view
        let toView = toVC.view
        viewWidth = fromVC.view.bounds.width
        
        containerView.layer.sublayerTransform = perspectiveTransform
        
        let wrapperView: UIView = TransitionView(frame: fromView.frame)
        wrapperView.autoresizesSubviews = true
        wrapperView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        containerView.addSubview(wrapperView)
        fromView.frame.origin = CGPoint.zero
        toView.frame.origin = CGPoint.zero
        wrapperView.addSubview(fromView)
        wrapperView.addSubview(toView)
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.shouldLayersRasterize([fromView.layer, toView.layer], shouldRasterize: false)
            
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            wrapperView.layer.transform = CATransform3DIdentity
            
            fromView.frame = wrapperView.frame
            toView.frame = containerView.frame
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            wrapperView.removeFromSuperview()
        }
        
        fromView.layer.doubleSided = false
        toView.layer.doubleSided = false
        shouldLayersRasterize([fromView.layer, toView.layer], shouldRasterize: true)
        
        fromView.layer.addAnimation(animation().fromAnimation, forKey: "fromVC")
        toView.layer.addAnimation(animation().toAnimation, forKey: "toVC")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let containerView = transitionContext?.containerView()
        containerView?.layer.sublayerTransform = CATransform3DIdentity
        
        let cancelled = transitionContext?.transitionWasCancelled() ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}

// MARK: - Help
private extension FlipAnimatedTransitioning {
    func animation() -> (fromAnimation: CAAnimationGroup, toAnimation: CAAnimationGroup) {
        let factor: CGFloat = dismiss ? 1 : -1
        let zPositionAnimation = CAKeyframeAnimation(keyPath: "zPosition")
        zPositionAnimation.values = [-0.0, -viewWidth * 0.5, -0.0]
        zPositionAnimation.timingFunctions = getCircleApproximationTimingFunctions()
        
        var fromTransform = CATransform3DIdentity
        var toTransform = CATransform3DIdentity
        fromTransform = CATransform3DRotate(fromTransform, -M_PI.f + 0.001 * factor, 0.0, 1.0, 0.0)
        toTransform = CATransform3DRotate(toTransform, M_PI.f - 0.001 * factor, 0.0, 1.0, 0.0)
        
        let fromFlipAnimation = CABasicAnimation(keyPath: "transform")
        fromFlipAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        fromFlipAnimation.toValue = NSValue(CATransform3D: fromTransform)
        fromFlipAnimation.duration = duration
        fromFlipAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let toFlipAnimation = CABasicAnimation(keyPath: "transform")
        toFlipAnimation.fromValue = NSValue(CATransform3D: toTransform)
        toFlipAnimation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        toFlipAnimation.duration = duration
        toFlipAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let fromAnimation: CAAnimationGroup = CAAnimationGroup()
        fromAnimation.animations = [fromFlipAnimation, zPositionAnimation]
        fromAnimation.duration = duration
        
        let toAnimation: CAAnimationGroup = CAAnimationGroup()
        toAnimation.animations = [toFlipAnimation, zPositionAnimation]
        toAnimation.duration = duration
        toAnimation.delegate = self
        
        return (fromAnimation, toAnimation)
    }
}
