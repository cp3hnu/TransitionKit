//
//  CircleViewController.swift
//  Example
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class CircleViewController: UIViewController, CircleTransitionClicked {
    
    private let circleTransition = CircleTransition()
    var clickedPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Circle"
        view.backgroundColor = UIColor.whiteColor()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.delegate = nil
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let point = gesture.locationInView(view)
        clickedPoint = point

        let vc = ViewController()
        navigationController?.delegate = circleTransition
        navigationController?.pushViewController(vc, animated: true)
    }
}
