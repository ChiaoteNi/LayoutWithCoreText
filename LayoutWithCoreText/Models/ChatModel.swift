//
//  ChatModel.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import Foundation

struct ChatModel {
    var type: MessageType
    var content: String
}

enum MessageType {
    case fromSelf
    case fromOthers
}
