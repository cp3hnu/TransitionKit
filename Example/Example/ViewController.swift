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
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let point = gesture.locationInView(view)
        clickedPoint = point
        navigationController?.popViewControllerAnimated(true)
    }
}
