//
//  TableViewController.swift
//  Example
//
//  Created by CP3 on 16/8/3.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let array = ["SemiModel", "Gate", "Circle", "Rotation", "Flip", "Book", "Cube", "Blur"]
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
        var controller: UIViewController?
        
        switch indexPath.row {
        case 0:
            controller = SemiModelViewController()
        case 1:
            controller = GateViewController()
        case 2:
            controller = CircleViewController()
        case 3:
            controller = RotationViewController()
        case 4:
            controller = FlipViewController()
        case 5:
            controller = BookViewController()
        case 6:
            controller = CubeViewController()
        case 7:
            controller = BlurViewController()
        default:
            break
        }
        
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}
