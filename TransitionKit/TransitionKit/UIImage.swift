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
    
    func splitIntoTwoSawtoothParts(distance: CGFloat, count: Int) -> [UIImage] {
        var array = [UIImage]()
        let width = size.width
        let height = size.height
        let widthGap = distance
        let positiveCount = max(1, count)
        let heightGap = height/positiveCount.f
        
        let leftPath = CGMutablePath()
        leftPath.move(to: CGPoint.zero)
        var direction: Int = -1
        for i in 0...positiveCount {
            leftPath.addLine(to: CGPoint(x: width/2 + (widthGap * direction.f), y: heightGap * i.f))
            direction *= -1
        }
        leftPath.addLine(to: CGPoint(x: 0, y: height))
        leftPath.closeSubpath()
        let leftImage = createImageInPath(leftPath)
        array.append(leftImage)
        
        //part two
        let rightPath = CGMutablePath()
        rightPath.move(to: CGPoint(x: width, y: 0))
        direction = -1
        for i in 0...positiveCount {
            rightPath.addLine(to: CGPoint(x: width/2 + (widthGap * direction.f), y: heightGap * i.f))
            direction *= -1
        }
        rightPath.addLine(to: CGPoint(x: width, y: height))
        rightPath.closeSubpath()
        let rightImage = createImageInPath(rightPath)
        array.append(rightImage)
        return array
    }
    
    func createImageInPath(_ path: CGPath) -> UIImage {
        let scale = UIScreen.main.scale
        let width = size.width
        let height = size.height
        UIGraphicsBeginImageContext(CGSize(width: width * scale, height: height * scale))
        let context = UIGraphicsGetCurrentContext()!
        context.scaleBy(x: scale, y: scale)
        context.addPath(path)
        context.clip()
        draw(at: CGPoint.zero)
        let maskedImage = context.makeImage()!
        let image = UIImage(cgImage: maskedImage, scale: scale, orientation: .up)
        UIGraphicsEndImageContext()
        
        return image
    }
}
