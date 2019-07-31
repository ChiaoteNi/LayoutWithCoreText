//
//  ExpandableContentVC.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/30.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class ExpandableContentVC: BaseVC {
    
    @IBOutlet private weak var introLabel: UILabel!
    @IBOutlet private weak var introLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var introLabelWidthConstraint: NSLayoutConstraint!
    
    private var defaultHeight: CGFloat = 0
    private var font: UIFont = .ct_messageContent

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = getShorterContentString()
        introLabel.attributedText = content
        
        defaultHeight = introLabelHeightConstraint.constant
    }
    
    @IBAction private func expandButtonDidTap() {
        let isExpanded = introLabelHeightConstraint.constant > defaultHeight
        
        if isExpanded {
            displayShorterIntro()
        } else {
            spreadFullIntro()
        }
    }
}

// MARK: - Private funcs.
extension ExpandableContentVC {
    
    private func spreadFullIntro() {
        let txt = getContentString()
        introLabel.attributedText = txt
        let height = TypesettingHelper.getContentHeight(with: txt,
                                                     width: introLabelWidthConstraint.constant,
                                                     maxHeight: UIScreen.main.bounds.height * 100)// + (font.pointSize * 2)
        introLabelHeightConstraint.constant = height
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func displayShorterIntro() {
        let txt = getShorterContentString()
        introLabel.attributedText = txt
        introLabelHeightConstraint.constant = defaultHeight
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func getContentString() -> NSAttributedString {
        let content = ContentFactory.getClassicofMountainsandSeas()
        let attrString = TypesettingHelper.getAttributteString(for: content, with: font, color: .ct_text)
        return attrString
    }
    
    private func getShorterContentString() -> NSAttributedString? {
        let attrString = getContentString()
        let rect = CGRect.init(x: 0, y: 0,
                               width: introLabelWidthConstraint.constant,
                               height: introLabelHeightConstraint.constant)
        return TypesettingHelper.split(attrString, in: rect).first
        
    }
}
