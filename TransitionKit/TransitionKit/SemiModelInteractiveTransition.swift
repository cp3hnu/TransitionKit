//
//  SemiModelInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

open class SemiModelInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    open var interactionInProgress = false
    fileprivate let distanceFromTop: CGFloat
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var controller: UIViewController?
    
    public init(distanceFromTop: CGFloat = 100) {
        self.distanceFromTop = distanceFromTop
        super.init()
    }
    
    open func wireToViewController(_ vc: UIViewController) {
        controller = vc
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        vc.view.addGestureRecognizer(pan)
    }
    
    @objc fileprivate func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let vc = controller else { return }
        
        let point = sender.translation(in: vc.view)
        switch sender.state {
        case .began:
            interactionInProgress = true
            vc.dismiss(animated: true, completion: nil)
        case .changed:
            let height = vc.view.bounds.height - distanceFromTop
            let fraction = point.y/height
            shouldCompleteTransition = fraction > 0.5
            update(fraction)
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
