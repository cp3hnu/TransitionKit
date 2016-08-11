//
//  BlurViewController.swift
//  Example
//
//  Created by CP3 on 16/8/10.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class BlurViewController: UIViewController {

    private let rotationTransition = BlurTransition(duration: 0.5)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Blur"
        view.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationController?.delegate = nil
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        let vc = ViewController()
        navigationController?.delegate = rotationTransition
        navigationController?.pushViewController(vc, animated: true)
        
        //vc.transitioningDelegate = transformTransition
        //presentViewController(vc, animated: true, completion: nil)
    }

}
