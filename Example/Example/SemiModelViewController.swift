//
//  SemiModelViewController.swift
//  Example
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class SemiModelViewController: TransitionViewController {
    
    override func tap(_ gesture: UITapGestureRecognizer) {
        let vc = ViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transition
        present(vc, animated: true, completion: nil)
    }
}

