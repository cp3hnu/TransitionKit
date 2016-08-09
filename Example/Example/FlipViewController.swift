//
//  FlipViewController.swift
//  Example
//
//  Created by CP3 on 16/8/9.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class FlipViewController: UIViewController {

    private let rotationTransition = FlipTransition(duration: 0.6)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flip"
        view.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.delegate = nil
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let vc = ViewController()
        navigationController?.delegate = rotationTransition
        navigationController?.pushViewController(vc, animated: true)
        
        //vc.transitioningDelegate = transformTransition
        //presentViewController(vc, animated: true, completion: nil)
    }
}