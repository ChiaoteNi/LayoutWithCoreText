//
//  ChatFromSelfCell2.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/30.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class ChatFromSelfCell: BaseChatCell {
    
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.isFrom = .right
        bubbleView.tintColor = .ct_chatBubbleFromSelf
        
        seperateLine.backgroundColor = .ct_seperatorLine
        expendStatusLb.textColor = .ct_chatExpendBtnTint
        expendArrowView.tintColor = .ct_chatExpendBtnTint
    }
}
