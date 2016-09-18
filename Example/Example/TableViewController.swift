//
//  TableViewController.swift
//  Example
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import TransitionKit

class TableViewController: UITableViewController {

    let array = ["SemiModel", "Gate", "Circle", "Rotation", "Flip", "Book", "Cube", "Blur", "Glue"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TransitionKit"
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = array[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var controller: TransitionViewController?
        
        switch indexPath.row {
        case 0:
            // SemiModel
            controller = SemiModelViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = SemiModelTransition(distanceFromTop: 200)
        case 1:
            // Gate
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = GateTransition(sawtoothCount: 20, sawtoothDistance: 20, duration: 0.3)
        case 2:
            // Circle
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = CircleTransition()
        case 3:
            // Rotation
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = RotationTransition(duration: 0.3)
        case 4:
            // Flip
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = FlipTransition(duration: 0.3)
        case 5:
            // Book
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = BookTransition(duration: 0.3)
            
        case 6:
            // Cube
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = CubeTransition(duration: 0.3)
        case 7:
            // Blur
            controller = TransitionViewController()
            controller?.title = array[indexPath.row]
            controller?.transition = BlurTransition(duration: 0.5)
        default:
            break
        }
        
        controller?.mode = .Push
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}
