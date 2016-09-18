//
//  UIView.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation

extension UIView {
    func splitIntoTwoSawtoothParts(distance: CGFloat, count: Int) -> [UIView] {
        let image = captureViewSnapshot()
        let array = image.splitIntoTwoSawtoothParts(distance: distance, count: count)
        return [UIImageView(image: array[0]), UIImageView(image: array[1])]
    }
    
    func captureViewSnapshot() -> UIImage {
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()!
        layer.render(in: context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
