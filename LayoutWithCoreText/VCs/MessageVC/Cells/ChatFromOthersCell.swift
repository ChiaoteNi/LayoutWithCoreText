//
//  ChatFromOthersCell.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/30.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class ChatFromOthersCell: BaseChatCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.isFrom = .left
        
        seperateLine.backgroundColor = .ct_seperatorLine
        expendStatusLb.textColor = .ct_chatExpendBtnTint
        expendArrowView.tintColor = .ct_chatExpendBtnTint
    }
}
