//
//  CGFloat.swift
//  TransitionKit
//
//  Created by CP3 on 16/8/2.
//  Copyright © 2016年 CP3. All rights reserved.
//

import Foundation


extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
    var swd: Double { return Double(self) }
    var swi: Int { return Int(self) }
}