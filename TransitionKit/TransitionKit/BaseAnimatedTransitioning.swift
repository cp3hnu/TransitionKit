//
//  BaseAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class BaseAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    var dismiss = false
    var duration: NSTimeInterval = 0.3
    
    var perspectiveTransform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        return transform
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        animateTransition(transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        fatalError("animateTransition(transitionContext:) has not been implemented")
    }
}

extension BaseAnimatedTransitioning {
    func shouldLayersRasterize(layers: [CALayer], shouldRasterize: Bool) {
        layers.forEach {
            $0.shouldRasterize = shouldRasterize
            $0.rasterizationScale = UIScreen.mainScreen().scale
        }
    }
    
    func getCircleApproximationTimingFunctions() -> [CAMediaTimingFunction] {
        // The following CAMediaTimingFunction mimics zPosition = sin(t)
        // Empiric (possibly incorrect, but it does the job) implementation based on the circle approximation with bezier cubic curves
        // ( http://www.whizkidtech.redprince.net/bezier/circle/ )
        // sin(t) tangent for t=0 is a diagonal. But we have to remap x=[0PI/2] to t=[01]. => scale with M_PI/2.0f factor
        
        let kappa: Float = 4.0/3.0 * (sqrt(2.0) - 1.0) / sqrt(2.0)
        let firstQuarterCircleApproximationFuction = CAMediaTimingFunction(controlPoints: kappa/Float(M_PI_2), kappa, 1.0 - kappa, 1.0)
        let secondQuarterCircleApproximationFuction = CAMediaTimingFunction(controlPoints: kappa, 0.0, 1.0 - kappa/Float(M_PI_2), 1.0 - kappa)
        return [firstQuarterCircleApproximationFuction, secondQuarterCircleApproximationFuction]
    }
}

class TransitionView : UIView {
    override class func layerClass() -> AnyClass {
        return CATransformLayer.self
    }
}
