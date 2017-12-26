//
//  ViewController.swift
//  Example
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        view.backgroundColor = UIColor.red
        
        let imageView = UIImageView(image: UIImage(named: "b"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    @objc func tap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: view)
        
        if let transition = navigationController?.delegate as? CircleTransition {
            transition.clickedPoint = point
        }
        
        if let navi = navigationController {
           navi.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
