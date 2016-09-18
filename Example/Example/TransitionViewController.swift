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
    case present
    case push
}

class TransitionViewController: UIViewController {

    var transition: (UIViewControllerTransitioningDelegate & UINavigationControllerDelegate)!
    var mode = PresentMode.present
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    func tap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: view)
        if let transition = transition as? CircleTransition {
            transition.clickedPoint = point
        } else if let transition = transition as? BookTransition {
            transition.isPresent = (mode == PresentMode.present)
        } else if let transition = transition as? GateTransition {
            transition.isPresent = (mode == PresentMode.present)
        }
        
        let vc = ViewController()
        if mode == PresentMode.push {
            navigationController?.delegate = transition
            navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.transitioningDelegate = transition
            present(vc, animated: true, completion: nil)
        }
    }
}
