//
//  FlipAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/9.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class FlipAnimatedTransitioning: BaseAnimatedTransitioning {
    
    fileprivate var viewWidth: CGFloat = UIScreen.main.bounds.width
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        let fromView = fromVC.view!
        let toView = toVC.view!
        viewWidth = fromVC.view.bounds.width
        containerView.layer.sublayerTransform = perspectiveTransform
        
        let wrapperView: UIView = TransitionView(frame: fromView.frame)
        wrapperView.autoresizesSubviews = true
        wrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(wrapperView)
        fromView.frame.origin = CGPoint.zero
        toView.frame.origin = CGPoint.zero
        wrapperView.addSubview(fromView)
        wrapperView.addSubview(toView)
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.shouldRasterize(layers: [fromView.layer, toView.layer], rasterized: false)
            
            fromView.layer.transform = CATransform3DIdentity
            toView.layer.transform = CATransform3DIdentity
            wrapperView.layer.transform = CATransform3DIdentity
            
            fromView.frame = wrapperView.frame
            toView.frame = containerView.frame
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            wrapperView.removeFromSuperview()
            
            containerView.layer.sublayerTransform = CATransform3DIdentity
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
        
        CATransaction.begin()
        fromView.layer.isDoubleSided = false
        toView.layer.isDoubleSided = false
        shouldRasterize(layers: [fromView.layer, toView.layer], rasterized: true)
        fromView.layer.add(createLayerAnimation().fromAnimation, forKey: "fromVC")
        toView.layer.add(createLayerAnimation().toAnimation, forKey: "toVC")
        CATransaction.commit()
    }
}

// MARK: - Help
private extension FlipAnimatedTransitioning {
    func createLayerAnimation() -> (fromAnimation: CAAnimationGroup, toAnimation: CAAnimationGroup) {
        let factor: CGFloat = dismiss ? 1 : -1
        let zPositionAnimation = CAKeyframeAnimation(keyPath: "zPosition")
        zPositionAnimation.values = [-0.0, -viewWidth * 0.5, -0.0]
        zPositionAnimation.timingFunctions = getCircleApproximationTimingFunctions()
        
        var fromTransform = CATransform3DIdentity
        var toTransform = CATransform3DIdentity
        fromTransform = CATransform3DRotate(fromTransform, -Double.pi.f + 0.001 * factor, 0.0, 1.0, 0.0)
        toTransform = CATransform3DRotate(toTransform, Double.pi.f - 0.001 * factor, 0.0, 1.0, 0.0)
        
        let fromFlipAnimation = CABasicAnimation(keyPath: "transform")
        fromFlipAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        fromFlipAnimation.toValue = NSValue(caTransform3D: fromTransform)
        fromFlipAnimation.duration = duration
        fromFlipAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let toFlipAnimation = CABasicAnimation(keyPath: "transform")
        toFlipAnimation.fromValue = NSValue(caTransform3D: toTransform)
        toFlipAnimation.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        toFlipAnimation.duration = duration
        toFlipAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let fromAnimation = CAAnimationGroup()
        fromAnimation.animations = [fromFlipAnimation, zPositionAnimation]
        fromAnimation.duration = duration
        
        let toAnimation = CAAnimationGroup()
        toAnimation.animations = [toFlipAnimation, zPositionAnimation]
        toAnimation.duration = duration
        
        return (fromAnimation, toAnimation)
    }
}
