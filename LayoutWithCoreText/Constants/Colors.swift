//
//  Colors.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

extension UIColor {
    //MARK: - Common
    static var ct_seperatorLine: UIColor { return .darkGray }
    static var ct_clear: UIColor         { return UIColor.white.withAlphaComponent(0) }
    // Txt
    static var ct_text: UIColor          { return .black }
    // ChatCellBubble
    static var ct_chatBubbleBorder: UIColor         { return .darkGray }
    static var ct_chatBubbleFromSelf: UIColor       { return UIColor(hexString: "7BBFFF") }
    static var ct_chatBubbleFromOthers: UIColor     { return .white }
    // TextChatCell
    static var ct_chatExpendBtnTint: UIColor        { return .darkGray }
}
