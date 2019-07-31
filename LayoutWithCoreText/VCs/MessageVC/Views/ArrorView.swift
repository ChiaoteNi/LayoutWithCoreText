//
//  ArrorView.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class ArrorView: UIView {
    
    enum Direction {
        case up, down, left, right
    }
    
    private var arrorLayer: CAShapeLayer = .init()
    var direct: Direction = .up {
        didSet {
            guard direct != oldValue else { return }
            arrorLayer.path = getBublePath(in: bounds, direct: direct).cgPath
        }
    }
    
    override var tintColor: UIColor! {
        didSet { arrorLayer.strokeColor = tintColor.cgColor }
    }
    
    override var frame: CGRect {
        didSet { updatePath(with: bounds) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updatePath(with: bounds)
    }
    
    private func initSetup() {
        arrorLayer.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        arrorLayer.strokeColor = UIColor.darkGray.cgColor
        arrorLayer.lineWidth = 1
        arrorLayer.masksToBounds = false
        
        arrorLayer.drawsAsynchronously = true
        layer.drawsAsynchronously = true
        
        layer.addSublayer(arrorLayer)
        layer.masksToBounds = false
        backgroundColor = .clear
    }
    
    private func updatePath(with rect: CGRect) {
        let path = getBublePath(in: rect, direct: direct).cgPath
        arrorLayer.frame = rect
        arrorLayer.path = path
    }
    
    private func getBublePath(in rect: CGRect, direct: Direction) -> UIBezierPath {
        let maxY = rect.height * 2 / 3
        let minY = rect.height / 3
        
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0, y: maxY))
        path.addLineTo(x: rect.width/2, y: minY)
        path.addLineTo(x: rect.width, y: maxY)
        
        switch direct {
        case .up:
            break
        case .down:
            let mirrorOverXOrigin = CGAffineTransform.init(scaleX: 1.0, y: -1.0)
            let translate = CGAffineTransform.init(translationX: 0, y: rect.height)
            path.apply(mirrorOverXOrigin)
            path.apply(translate)
        case .right:
            let rotate = CGAffineTransform.init(rotationAngle: .pi / 2)
            let translate = CGAffineTransform.init(translationX: rect.width, y: 0)
            path.apply(rotate)
            path.apply(translate)
        case .left:
            let rotate = CGAffineTransform.init(rotationAngle: -.pi / 2)
            let translate = CGAffineTransform.init(translationX: 0, y: rect.height)
            path.apply(rotate)
            path.apply(translate)
        }
        return path
    }
}

