//
//  SecondViewController.swift
//  Example
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .Custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Second"
        view.backgroundColor = UIColor.redColor()
    }
}
