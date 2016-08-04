//
//  BookInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/4.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BookInteractiveTransition: UIPercentDrivenInteractiveTransition {
    public var interactionInProgress = false
    public var isPresent = true
    private var shouldCompleteTransition = false
    private weak var controller: UIViewController?
    
    public func wireToViewController(vc: UIViewController) {
        controller = vc
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        vc.view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        guard let vc = controller else { return }
        
        let point = sender.translationInView(vc.view)
        switch sender.state {
        case .Began:
            interactionInProgress = true
            if isPresent {
                vc.dismissViewControllerAnimated(true, completion: nil)
            } else {
                vc.navigationController?.popViewControllerAnimated(true)
            }
        case .Changed:
            let width = vc.view.bounds.width
            let fraction = point.x/width
            shouldCompleteTransition = fraction > 0.3
            updateInteractiveTransition(fraction)
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
