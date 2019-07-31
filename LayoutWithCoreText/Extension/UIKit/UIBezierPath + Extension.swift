//
//  UIBezierPath + Extension.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

extension UIBezierPath {
    func moveTo(x: CGFloat, y: CGFloat) {
        move(to: CGPoint(x: x, y: y))
    }
    
    func addLineTo(x: CGFloat, y: CGFloat) {
        addLine(to: CGPoint(x: x, y: y))
    }
    
    func addCurveTo(x: CGFloat, y: CGFloat, ctrPt1: CGPoint, ctrPt2: CGPoint) {
        addCurve(to: CGPoint(x: x, y: y), controlPoint1: ctrPt1, controlPoint2: ctrPt2)
    }
}

