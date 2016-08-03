//
//  UIImage.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import UIKit
import CoreFoundation

extension UIImage {
    
    func splitIntoTwoSawtoothParts(distance distance: CGFloat, count: Int) -> [UIImage] {
        var array = [UIImage]()
        let width = size.width
        let height = size.height
        let widthGap = distance
        let positiveCount = max(1, count)
        let heightGap = height/positiveCount.f
        
        let leftPath = CGPathCreateMutable()
        CGPathMoveToPoint(leftPath, nil, 0, 0)
        var direction: Int = -1
        for i in 0...positiveCount {
            CGPathAddLineToPoint(leftPath, nil, width/2 + (widthGap * direction.f), heightGap * i.f)
            direction *= -1
        }
        CGPathAddLineToPoint(leftPath, nil, 0, height)
        CGPathCloseSubpath(leftPath)
        let leftImage = createImageInPath(leftPath)
        array.append(leftImage)
        
        //part two
        let rightPath = CGPathCreateMutable()
        CGPathMoveToPoint(rightPath, nil, width, 0)
        direction = -1
        for i in 0...positiveCount {
            CGPathAddLineToPoint(rightPath, nil, width/2 + (widthGap * direction.f), heightGap * i.f)
            direction *= -1
        }
        CGPathAddLineToPoint(rightPath, nil, width, height)
        CGPathCloseSubpath(rightPath)
        let rightImage = createImageInPath(rightPath)
        array.append(rightImage)
        return array
    }
    
    func createImageInPath(path: CGPathRef) -> UIImage {
        let scale = UIScreen.mainScreen().scale
        let width = size.width
        let height = size.height
        UIGraphicsBeginImageContext(CGSizeMake(width * scale, height * scale))
        let context = UIGraphicsGetCurrentContext()!
        CGContextScaleCTM(context, scale, scale)
        CGContextAddPath(context, path)
        CGContextClip(context)
        drawAtPoint(CGPointZero)
        let maskedImage = CGBitmapContextCreateImage(context)!
        let image = UIImage(CGImage: maskedImage, scale: scale, orientation: .Up)
        UIGraphicsEndImageContext()
        
        return image
    }
}