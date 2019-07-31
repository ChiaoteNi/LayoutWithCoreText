//
//  TxtCell.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/28.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

final class TxtCell: UICollectionViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!

    @IBOutlet private weak var topInset: NSLayoutConstraint!
    @IBOutlet private weak var bottomInset: NSLayoutConstraint!
    @IBOutlet private weak var leftInset: NSLayoutConstraint!
    @IBOutlet private weak var rightInset: NSLayoutConstraint!
    
    var contentInset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { contentInsetDidChange(to: contentInset) }
    }
    
    private func contentInsetDidChange(to inset: UIEdgeInsets) {
        topInset.constant = inset.top
        bottomInset.constant = inset.bottom
        leftInset.constant = inset.left
        rightInset.constant = inset.right
    }
}
