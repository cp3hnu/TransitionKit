//
//  ViewController.swift
//  Example
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class ViewController: UIViewController {

    private let semiModelTransition = SemiModelTransition(distance: 200)
    private let gateTransition = GateTransition(sawtoothCount: 1, sawtoothDistance: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        navigationController?.delegate = gateTransition
    }

    @IBAction func push(sender: AnyObject) {
        let controller = SecondViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func present(sender: AnyObject) {
        let controller = SecondViewController()
        controller.transitioningDelegate = semiModelTransition
        presentViewController(controller, animated: true, completion: nil)
    }
}

