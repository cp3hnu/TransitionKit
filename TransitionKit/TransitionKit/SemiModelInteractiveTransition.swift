//
//  SemiModelInteractiveTransition.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

public class SemiModelInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    public var interactionInProgress = false
    private let distanceFromTop: CGFloat
    private var shouldCompleteTransition = false
    private weak var controller: UIViewController?
    
    public init(distance: CGFloat = 100) {
        distanceFromTop = distance
        super.init()
    }
    
    public func wireToViewController(vc: UIViewController) {
        controller = vc
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        vc.view.addGestureRecognizer(panGR)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        guard let vc = controller else { return }
        
        let point = sender.translationInView(vc.view)
        switch sender.state {
        case .Began:
            interactionInProgress = true
            vc.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            let height = vc.view.bounds.height - distanceFromTop
            let fraction = point.y/height
            shouldCompleteTransition = fraction > 0.5
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
