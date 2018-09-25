//
//  GateAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class GateAnimatedTransitioning: BaseAnimatedTransitioning {
    fileprivate let sawtoothCount: Int
    fileprivate let sawtoothDistance: CGFloat
    fileprivate let scale: CGFloat = 0.5
    
    init(sawtoothCount: Int, sawtoothDistance: CGFloat) {
        self.sawtoothCount = sawtoothCount
        self.sawtoothDistance = sawtoothDistance
        
        super.init()
    }
    
   override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        let view = !dismiss ? fromVC.view! : toVC.view!
        let array: [UIView] = view.splitIntoTwoSawtoothParts(distance: sawtoothDistance, count: sawtoothCount)
        let leftView: UIView = array[0]
        let rightView: UIView = array[1]
        containerView.addSubview(leftView)
        containerView.addSubview(rightView)
        if !dismiss {
            fromVC.view.alpha = 0
            toVC.view.transform = CGAffineTransform(scaleX: scale, y: scale)
            containerView.addSubview(toVC.view)
            containerView.sendSubviewToBack(toVC.view)
        }
        let leftFrame = leftView.frame
        let leftOffScreenFrame = leftView.bounds.offsetBy(dx: -leftView.bounds.width/2 - sawtoothDistance, dy: 0)
        let rightFrame = rightView.frame
        let rightOffScreenFrame = rightView.bounds.offsetBy(dx: rightView.bounds.width/2 + sawtoothDistance, dy: 0)
        let leftInitialFrame = !dismiss ? leftFrame : leftOffScreenFrame
        let leftFinalFrame = !dismiss ? leftOffScreenFrame : leftFrame
        let rightInitialFrame = !dismiss ? rightFrame : rightOffScreenFrame
        let rightFinalFrame = !dismiss ? rightOffScreenFrame : rightFrame
        leftView.frame = leftInitialFrame
        rightView.frame = rightInitialFrame
    
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(), animations: {
            leftView.frame = leftFinalFrame
            rightView.frame = rightFinalFrame
            if !self.dismiss {
                toVC.view.transform = CGAffineTransform.identity
            } else {
                fromVC.view.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }
            }, completion: { _ in
                leftView.removeFromSuperview()
                rightView.removeFromSuperview()
                if !self.dismiss {
                    fromVC.view.alpha = 1.0
                } else {
                    containerView.addSubview(toVC.view)
                    fromVC.view.transform = CGAffineTransform.identity
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
