//
//  BookInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

open class BookInteractiveTransition: UIPercentDrivenInteractiveTransition {
    open var interactionInProgress = false
    open var isPresent = false
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var controller: UIViewController?
    
    open func wireToViewController(_ vc: UIViewController) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        vc.view.addGestureRecognizer(pan)
        controller = vc
    }
    
    @objc fileprivate func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let vc = controller else { return }
        
        let point = sender.translation(in: vc.view)
        switch sender.state {
        case .began:
            interactionInProgress = true
            if isPresent {
                vc.dismiss(animated: true, completion: nil)
            } else {
                vc.navigationController?.popViewController(animated: true)
            }
        case .changed:
            let width = vc.view.bounds.width
            let fraction = point.x/width + 0.23
            print(fraction)
            shouldCompleteTransition = fraction > 0.4
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
