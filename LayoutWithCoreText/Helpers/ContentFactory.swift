//
//  ContentFactory.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import Foundation

final class ContentFactory {
    static func getClassicofMountainsandSeas() -> String {
        return getTxtFromFile(name: "ClassicofMountainsandSeas")
    }
    
    static func getHumanInterfaceGuideline() -> String {
        return getTxtFromFile(name: "PartOfHumanInterfaceGuideline")
    }
    
    static func getMessageModels() -> [ChatModel] {
        var models: [ChatModel] = []
        let msgs = getMessages()
        for i in 0 ..< msgs.count {
            let type: MessageType = i % 2 == 0 ? .fromSelf : .fromOthers
            let model: ChatModel = ChatModel(type: type, content: msgs[safe: i] ?? "")
            models.append(model)
        }
        return models
    }
}

extension ContentFactory {
    static private func getTxtFromFile(name: String, extensionType: String? = nil, encoding: String.Encoding = .utf8) -> String {
        guard let dataPath = Bundle.main.url(forResource: name, withExtension: extensionType) else { return "" }
        guard let txt = try? String.init(contentsOf: dataPath, encoding: encoding) else { return "" }
        return txt
    }
    
    static private func getMessages() -> [String] {
        let messages: [String] = [
            "HI", "你好", "這是測試", "這是測試2", "Try to say something.", "Sure", "WHAT's WRONG WITH U!!!!!", "........",
            "漢皇重色思傾國，御宇多年求不得。\n楊家有女初長成，養在深閨人未識。\n天生麗質難自棄，一朝選在君王側。\n回眸一笑百媚生，六宮粉黛無顏色。",
            "HI", "你好", "這是測試", "這是測試2", "Try to say something.", "Sure", "WHAT's WRONG WITH U!!!!!", "........",
            "漢皇重色思傾國，御宇多年求不得。\n楊家有女初長成，養在深閨人未識。\n天生麗質難自棄，一朝選在君王側。\n回眸一笑百媚生，六宮粉黛無顏色。",
            "HI", "你好", "這是測試", "這是測試2", "Try to say something.", "Sure", "WHAT's WRONG WITH U!!!!!", "........",
            "漢皇重色思傾國，御宇多年求不得。\n楊家有女初長成，養在深閨人未識。\n天生麗質難自棄，一朝選在君王側。\n回眸一笑百媚生，六宮粉黛無顏色。",
            "HI", "你好", "這是測試", "這是測試2", "Try to say something.", "Sure", "WHAT's WRONG WITH U!!!!!", "........",
            "漢皇重色思傾國，御宇多年求不得。\n楊家有女初長成，養在深閨人未識。\n天生麗質難自棄，一朝選在君王側。\n回眸一笑百媚生，六宮粉黛無顏色。",
            "HI", "你好", "這是測試", "這是測試2", "Try to say something.", "Sure", "WHAT's WRONG WITH U!!!!!", "........",
            "來篇山海經", getClassicofMountainsandSeas()
        ]
        return messages
    }
}
