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
    var duration: TimeInterval = 0.3
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    var perspectiveTransform: CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        return transform
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        animateTransition(transitionContext: transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        fatalError("Has not been implemented")
    }
}

extension BaseAnimatedTransitioning {
    func shouldRasterize(layers: [CALayer], rasterized: Bool) {
        layers.forEach {
            $0.shouldRasterize = rasterized
            $0.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func getCircleApproximationTimingFunctions() -> [CAMediaTimingFunction] {
        // The following CAMediaTimingFunction mimics zPosition = sin(t)
        // Empiric (possibly incorrect, but it does the job) implementation based on the circle approximation with bezier cubic curves
        // ( http://www.whizkidtech.redprince.net/bezier/circle/ )
        // sin(t) tangent for t=0 is a diagonal. But we have to remap x=[0PI/2] to t=[01]. => scale with Double.pi/2.0f factor
        
        let kappa: Float = 4.0/3.0 * (sqrt(2.0) - 1.0) / sqrt(2.0)
        let firstQuarterCircleApproximationFuction = CAMediaTimingFunction(controlPoints: kappa/Float(Double.pi/2), kappa, 1.0 - kappa, 1.0)
        let secondQuarterCircleApproximationFuction = CAMediaTimingFunction(controlPoints: kappa, 0.0, 1.0 - kappa/Float(Double.pi/2), 1.0 - kappa)
        return [firstQuarterCircleApproximationFuction, secondQuarterCircleApproximationFuction]
    }
}

class TransitionView: UIView {
    override class var layerClass: AnyClass {
        return CATransformLayer.self
    }
}

extension CGPoint {
    mutating func translate(dx: CGFloat, dy: CGFloat) {
        x -= dx
        y -= dy
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        let oldOrigin = frame.origin
        layer.anchorPoint = point
        let newOrigin = frame.origin
        
        let translateX = newOrigin.x - oldOrigin.x
        let translateY = newOrigin.y - oldOrigin.y
        
        center.translate(dx: translateX, dy: translateY)
    }
}
