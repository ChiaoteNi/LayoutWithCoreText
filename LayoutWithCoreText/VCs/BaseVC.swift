//
//  BaseVC.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/28.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    var closeBtn: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.setTitle("", for: .normal)
        closeBtn.setImage(getCloseIcon(), for: .normal)
        closeBtn.frame = CGRect(x: UIScreen.main.bounds.width - 30, y: 50, width: 20, height: 20)
        closeBtn.addTarget(self, action: #selector(close), for: UIControl.Event.allEvents)
        view.insertSubview(closeBtn, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.bringSubviewToFront(closeBtn)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getCloseIcon() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 20, height: 20)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        path.move(to: .init(x: 5, y: 5))
        path.addLine(to: .init(x: 15, y: 15))
        path.move(to: .init(x: 15, y: 5))
        path.addLine(to: .init(x: 5, y: 15))
        
        let layer = CAShapeLayer()
        layer.frame = rect
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        
        guard let icon: UIImage = UIImage.init(layer: layer) else { return .init() }
        return icon
    }
}
