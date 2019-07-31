//
//  TypesettingHelper.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/28.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//
import UIKit

final class TypesettingHelper {
    
    static func getContentHeight(with attrString: NSAttributedString,
                                 width: CGFloat,
                                 maxHeight: CGFloat = UIScreen.main.bounds.height * 100) -> CGFloat {
        guard attrString.length > 0 else { return 0 }
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: maxHeight)
        let path = CGPath(rect: rect, transform: nil)
        let range = CFRangeMake(0, 0)
        let frame = CTFramesetterCreateFrame(framesetter, range, path, nil)
        let lines = CTFrameGetLines(frame) as! [CTLine]
        
        var origins: [CGPoint] = Array(repeating: CGPoint.zero, count: lines.count)
        CTFrameGetLineOrigins(frame, range, &origins)
        
//        for origin in origins {
//            print(origin)
//        }
        guard let targetLine = lines.last else { return 0 }
        guard let lineY = origins.last?.y else { return 0 }
        
        var descent: CGFloat = 0
        CTLineGetTypographicBounds(targetLine, nil, &descent, nil)
        
        let height = (maxHeight - lineY) + CGFloat(ceilf(Float(descent)))
        return height
    }
    
    static func split(_ attribustring: NSAttributedString, in rect: CGRect) -> [NSAttributedString] {
        let ranges = parse(attribustring: attribustring, rect: rect)
        var models: [NSAttributedString] = []
        for range in ranges {
            let attrString = attribustring.attributedSubstring(from: range)
            models.append(attrString)
        }
        return models
    }
}

extension TypesettingHelper {
    
    private static func parse(attribustring: NSAttributedString, rect: CGRect) -> [NSRange] {
        let frameSetter = CTFramesetterCreateWithAttributedString(attribustring as CFAttributedString)
        let path = CGPath(rect: rect, transform: nil)
        var cfRange = CFRangeMake(0, 0)
        var rangeOffset: NSInteger = 0
        var rangeArray: [NSRange] = []
        
        repeat {
            let contentRange = CFRangeMake(rangeOffset, attribustring.length - rangeOffset)
            let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, contentRange, path, nil)
            cfRange = CTFrameGetVisibleStringRange(frame)
            
            let range = NSRange(location: rangeOffset,
                                length: cfRange.length)
            rangeArray.append(range)
            
            rangeOffset += cfRange.length
        } while cfRange.location + cfRange.length < attribustring.length
        
        return rangeArray
    }
}

extension TypesettingHelper {
    
    static func getAttributteString(for txt: String, with font: UIFont, color: UIColor = .black) -> NSMutableAttributedString {
        let paragraphy: NSMutableParagraphStyle = .init()
        paragraphy.maximumLineHeight = 20
        paragraphy.paragraphSpacing = 0
        paragraphy.lineBreakMode = .byCharWrapping
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphy
        ]
        
        let attrString = NSMutableAttributedString.init(string: txt, attributes: attributes)
        return attrString
    }
}
