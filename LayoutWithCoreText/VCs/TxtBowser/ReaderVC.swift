//
//  ReaderVC.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/28.
//  Copyright © 2019 iOS@Taipei. All rights reserved.
//

import UIKit

enum ContentType {
    case classic
    case guidelines
}

prefix func !(_ target: ContentType) -> ContentType {
    return target == .classic ? .guidelines : .classic
}

final class ReaderVC: BaseVC {
    
    @IBOutlet private weak var readerView: ReaderView!
    @IBOutlet private weak var ctrlBarTrailingConstraint: NSLayoutConstraint!
    
    private var contentType: ContentType = .classic {
        didSet { contentDidChange(to: contentType, with: fontSize) }
    }
    
    private var fontSize: CGFloat = 12 {
        didSet { contentDidChange(to: contentType, with: fontSize) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(changeCtrlBarDisplayStatus))
        view.addGestureRecognizer(tap)
        
        ctrlBarTrailingConstraint.constant = -100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeCtrlBarDisplayStatus()
        contentType = .guidelines
    }
}

extension ReaderVC {
    @IBAction private func changeContentTxt() {
        contentType = !contentType
    }
    
    @IBAction private func changeFontSize() {
        fontSize = fontSize >= 24 ? 12 : fontSize + 4
    }
}

extension ReaderVC {
    
    private func contentDidChange(to type: ContentType, with fontSize: CGFloat) {
        let txt = getContent(with: type)
        readerView.show(txt: txt,
                        with: .systemFont(ofSize: fontSize),
                        title: "這是一個標題唷～",
                        titleFont: .systemFont(ofSize: fontSize + 5))
    }
    
    private func getContent(with type: ContentType) -> String {
        switch type {
        case .classic:
            return ContentFactory.getClassicofMountainsandSeas()
        case .guidelines:
            return ContentFactory.getHumanInterfaceGuideline()
        }
    }
    
    @objc private func changeCtrlBarDisplayStatus() {
        let currentSpacing = ctrlBarTrailingConstraint.constant
        ctrlBarTrailingConstraint.constant = currentSpacing == 0 ? -100 : 0
        UIView.animate(withDuration: 0.24) {
            self.view.layoutIfNeeded()
        }
    }
}
