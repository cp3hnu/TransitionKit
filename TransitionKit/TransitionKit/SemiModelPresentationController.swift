//
//  SemiModelPresentationController.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation


public class SemiModelPresentationController: UIPresentationController {
    private var dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        dimmingView.alpha = 0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
    }
    
    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        dimmingView.frame = containerView!.frame
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ context in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        dimmingView.frame = containerView!.frame
    }
}

private extension SemiModelPresentationController {
    @objc func dismiss() {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}