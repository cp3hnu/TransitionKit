//
//  GateInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class GateInteractiveTransition: UIPercentDrivenInteractiveTransition {
    public var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var navigationController: UINavigationController?
    private var startScale: CGFloat = 1.0
    
    public func wireToViewController(vc: UIViewController) {
        navigationController = vc.navigationController
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        vc.view.addGestureRecognizer(pinch)
    }
    
    @objc private func handlePinch(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .Began:
            interactionInProgress = true
            startScale = sender.scale
            navigationController?.popViewControllerAnimated(true)
        case .Changed:
            var fraction: Float = 1.0 - sender.scale.swf / startScale.swf
            fraction = fminf(fmaxf(fraction, 0.0), 1.0)
            shouldCompleteTransition = (fraction > 0.5)
            updateInteractiveTransition(fraction.f)
        case .Ended, .Cancelled:
            interactionInProgress = false
            if !shouldCompleteTransition || sender.state == .Cancelled {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
        default:
            break
        }
    }
}
