//
//  BlurAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/10.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class BlurAnimatedTransitioning: BaseAnimatedTransitioning {
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView()
        blurView.frame = fromVC.view.frame
        containerView.addSubview(blurView)
        toVC.view.frame.origin = CGPoint.zero
        
        UIView.animate(withDuration: duration/2, animations: {
            blurView.effect = effect
            }, completion: { _ in
                containerView.insertSubview(toVC.view, belowSubview: blurView)
                UIView.animate(withDuration: self.duration/2, animations: {
                    blurView.effect = nil
                    }, completion: { _ in
                        blurView.removeFromSuperview()
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
        })
    }
}
