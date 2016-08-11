//
//  GateViewController.swift
//  Example
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class GateViewController: UIViewController {
    
    private let gateTransition = GateTransition(sawtoothCount: 20, sawtoothDistance: 20, duration: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gate"
        view.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: UIImage(named: "a"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationController?.delegate = nil
    }
    
    func tap() {
        navigationController?.delegate = gateTransition
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
