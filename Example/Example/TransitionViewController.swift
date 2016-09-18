//
//  TransitionViewController.swift
//  Example
//
//  Created by CP3 on 16/9/8.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

enum PresentMode {
    case Present
    case Push
}

class TransitionViewController: UIViewController {

    var transition: protocol<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>!
    var mode = PresentMode.Present
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let point = gesture.locationInView(view)
        if let transition = transition as? CircleTransition {
            transition.clickedPoint = point
        } else if let transition = transition as? BookTransition {
            transition.isPresent = (mode == .Present)
        } else if let transition = transition as? GateTransition {
            transition.isPresent = (mode == .Present)
        }
        
        let vc = ViewController()
        if case PresentMode.Push = mode {
            navigationController?.delegate = transition
            navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.transitioningDelegate = transition
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}
