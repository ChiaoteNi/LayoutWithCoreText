//
//  BubbleView.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class ChatBubbleView: UIView {
    
    enum BubbleDirect {
        case right, left
    }
    
    var isFrom: BubbleDirect = .left
    var arrowLength: CGFloat = 5
    
    override var tintColor: UIColor! {
        didSet { bubleLayer.fillColor = tintColor.cgColor }
    }
    
    override var frame: CGRect {
        didSet { updateBuble(with: frame) }
    }
    
    private(set) var bubleLayer = CAShapeLayer.init()
    
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
        updateBuble(with: bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBuble(with: bounds)
    }
    
    private func initSetup() {
        bubleLayer.fillColor = UIColor.ct_chatBubbleFromOthers.cgColor
        bubleLayer.lineWidth = 0.5
        bubleLayer.strokeColor = UIColor.ct_chatBubbleBorder.cgColor
        bubleLayer.masksToBounds = false
        
        bubleLayer.drawsAsynchronously = true
        layer.drawsAsynchronously = true
        
        layer.addSublayer(bubleLayer)
        layer.masksToBounds = false
        backgroundColor = .ct_clear//.clear
    }
    
    private func updateBuble(with rect: CGRect) {
        guard rect.width != bubleLayer.frame.width || rect.height != bubleLayer.frame.height else { return }
        let path = getBublePath(in: rect, direct: isFrom).cgPath
        bubleLayer.frame = rect
        bubleLayer.path = path
    }
    
    private func getBublePath(in rect: CGRect, direct: BubbleDirect) -> UIBezierPath {
        let path = UIBezierPath()
        let startY = rect.height >= 50 ? 20 : rect.height/2
        
        path.moveTo(x: 0, y: startY)//rect.height/2)
        path.addLineTo(x: arrowLength, y: startY + 5)//rect.height/2 + 5)
        path.addLineTo(x: arrowLength, y: rect.height - 5)
        path.addCurveTo(x: arrowLength + 5, y: rect.height,
                        ctrPt1: CGPoint(x: arrowLength, y: rect.height - 3),
                        ctrPt2: CGPoint(x: arrowLength + 2, y: rect.height))
        path.addLineTo(x: rect.width - 5, y: rect.height)
        path.addCurveTo(x: rect.width, y: rect.height - 5,
                        ctrPt1: CGPoint(x: rect.width - 3, y: rect.height),
                        ctrPt2: CGPoint(x: rect.width, y: rect.height - 3))
        path.addLineTo(x: rect.width, y: 5)
        path.addCurveTo(x: rect.width - 5, y: 0,
                        ctrPt1: CGPoint(x: rect.width, y: 3),
                        ctrPt2: CGPoint(x: rect.width - 3, y: 0))
        path.addLineTo(x: arrowLength + 5, y: 0)
        path.addCurveTo(x: arrowLength, y: 5,
                        ctrPt1: CGPoint(x: arrowLength + 2, y: 0),
                        ctrPt2: CGPoint(x: arrowLength, y: 3))
        path.addLineTo(x: arrowLength, y: startY - 5)//rect.height/2 - 5)
        path.addLineTo(x: 0, y: startY)//rect.height/2)
        path.close()
        
        guard direct == .right else { return path }
        let mirrorOverXOrigin = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
        let translate = CGAffineTransform.init(translationX: rect.width, y: 0)
        path.apply(mirrorOverXOrigin)
        path.apply(translate)
        
        return path
    }
}

