//
//  SemiModelViewController.swift
//  Example
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class SemiModelViewController: UIViewController {

    private let semiModelTransition = SemiModelTransition(distanceFromTop: 200)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SemiModel"
        view.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    func tap() {
        let vc = ViewController()
        vc.modalPresentationStyle = .Custom
        vc.transitioningDelegate = semiModelTransition
        presentViewController(vc, animated: true, completion: nil)
    }
}

