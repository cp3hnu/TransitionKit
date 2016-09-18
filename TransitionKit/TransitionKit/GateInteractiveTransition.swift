//
//  GateInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

open class GateInteractiveTransition: UIPercentDrivenInteractiveTransition {
    open var interactionInProgress = false
    fileprivate var shouldCompleteTransition = false
    fileprivate var startScale: CGFloat = 1.0
    open var isPresent = false
    fileprivate weak var controller: UIViewController?
    
    open func wireToViewController(_ vc: UIViewController) {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        vc.view.addGestureRecognizer(pinch)
        controller = vc
    }
    
    @objc fileprivate func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let vc = controller else { return }
        
        switch sender.state {
        case .began:
            interactionInProgress = true
            startScale = sender.scale
            if isPresent {
                vc.dismiss(animated: true, completion: nil)
            } else {
                vc.navigationController?.popViewController(animated: true)
            }
        case .changed:
            var fraction: Float = 1.0 - sender.scale.swf / startScale.swf
            fraction = fminf(fmaxf(fraction, 0.0), 1.0)
            shouldCompleteTransition = (fraction > 0.5)
            update(fraction.f)
        case .ended, .cancelled:
            interactionInProgress = false
            if !shouldCompleteTransition || sender.state == .cancelled {
                cancel()
            } else {
                finish()
            }
        default:
            break
        }
    }
}
