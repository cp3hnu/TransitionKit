//
//  ViewController.swift
//  Example
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class ViewController: UIViewController, CircleTransitionClicked {

    var clickedPoint: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        view.backgroundColor = UIColor.redColor()
        
        let imageView = UIImageView(image: UIImage(named: "b"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let point = gesture.locationInView(view)
        clickedPoint = point
        if let navi = navigationController {
           navi.popViewControllerAnimated(true)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
