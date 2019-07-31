//
//  Images.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var ct_chatCoverFromSelf: UIImage    { return #imageLiteral(resourceName: "chatIcon_3") }
    static var ct_chatCoverFromOthers: UIImage  { return #imageLiteral(resourceName: "chatIcon_1") }
    static var ct_chatCoverFromOthers2: UIImage { return #imageLiteral(resourceName: "chatIcon_2") }

    static var ct_clear: UIImage? { return UIImage.init(named: "") }

    static func ct_custom(name: String?) -> UIImage? {
        guard let name = name else { return ct_clear }
        return UIImage.init(named: name)
    }
}
