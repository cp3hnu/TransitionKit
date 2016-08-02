//
//  BaseAnimatedTransitioning.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

public class BaseAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    public var dismiss = false
    public var duration: NSTimeInterval = 0.3
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        fatalError()
    }
}
