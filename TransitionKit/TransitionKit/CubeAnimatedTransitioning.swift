//
//  CubeAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/6.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class CubeAnimatedTransitioning: BaseAnimatedTransitioning {

    fileprivate var viewWidth: CGFloat = UIScreen.main.bounds.width
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        let fromView = fromVC.view!
        let toView = toVC.view!
        viewWidth = fromVC.view.bounds.width
        
        containerView.layer.sublayerTransform = perspectiveTransform
        
        let wrapperView: UIView = TransitionView(frame: fromView.frame)
        wrapperView.autoresizesSubviews = true
        wrapperView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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
        }
        
        fromView.layer.isDoubleSided = false
        toView.layer.isDoubleSided = false
        shouldRasterize(layers: [fromView.layer, toView.layer], rasterized: true)
        
        toView.layer.transform = CATransform3DIdentity
        fromView.layer.transform = fromTransform()
        
        wrapperView.layer.transform = CATransform3DInvert(CATransform3DIdentity)
        wrapperView.layer.add(animation(), forKey: nil)
    }
}

// MARK: - Help
private extension CubeAnimatedTransitioning {
    func fromTransform() -> CATransform3D {
        let factor: CGFloat = dismiss ? -1 : 1
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, -M_PI_2.f * factor, 0.0, 1.0, 0.0)
        transform = CATransform3DTranslate(transform, -viewWidth/2 * factor, 0.0, viewWidth/2)
        
        return transform
    }
    
    func animation() -> CAAnimationGroup {
        let factor: CGFloat = dismiss ? -1 : 1
        var rotation = CATransform3DIdentity
        rotation = CATransform3DTranslate(rotation, viewWidth/2 * factor, 0.0, -viewWidth/2)
        rotation = CATransform3DRotate(rotation, M_PI_2.f * factor, 0.0, 1.0, 0.0)
        
        let cubeRotation: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        cubeRotation.fromValue = NSValue(caTransform3D: rotation)
        cubeRotation.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        cubeRotation.duration = duration
        
        let zPositionAnimation = CAKeyframeAnimation(keyPath: "zPosition")
        zPositionAnimation.values = [0.0, -36.0, 0.0]
        zPositionAnimation.timingFunctions = getCircleApproximationTimingFunctions()
        zPositionAnimation.duration = duration
        
        let animation = CAAnimationGroup()
        animation.animations = [cubeRotation, zPositionAnimation]
        animation.duration = duration
        animation.delegate = self
        
        return animation
    }
}

extension CubeAnimatedTransitioning: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let containerView = transitionContext?.containerView
        containerView?.layer.sublayerTransform = CATransform3DIdentity
        
        let cancelled = transitionContext?.transitionWasCancelled ?? false
        transitionContext?.completeTransition(!cancelled)
    }
}


