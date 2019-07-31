//
//  BaseChatCell.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

protocol ChatTextCellDelegate: class {
    func chatTxtCell(didTapAt cell: BaseChatCell)
}

class BaseChatCell: UITableViewCell {
    
    @IBOutlet weak var nickNameLab: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var bubbleView: ChatBubbleView!
    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var expendStatusLb: UILabel!
    @IBOutlet weak var seperateLine: UIView!
    @IBOutlet weak var expendArrowView: ArrorView!
    @IBOutlet private weak var expendContainerView: UIView!
    
    @IBOutlet private weak var msgContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var txtLabBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var expendBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var seperateLineOffsetConstraint: NSLayoutConstraint!
    
    private let maxHeight: CGFloat = UIScreen.main.bounds.height / 1.5
    private let maxWidth: CGFloat = UIScreen.main.bounds.width - (84 * 2)
    
    weak var cellDelegate: ChatTextCellDelegate?
    
    var contentFont: UIFont = .ct_messageContent
    var txtcolor: UIColor = .ct_text
    
    var model: ChatModel! {
        didSet { chatModelDidChange(to: model) }
    }
    
    var isOpen: Bool = false {
        didSet { isOpenDidChanged(to: isOpen, from: oldValue) }
    }
    
    var isExtendable: Bool {
        return contentView.frame.height >= maxHeight
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView?.layer.cornerRadius = 5
        iconImageView?.layer.masksToBounds = true
        iconImageView?.contentMode = .scaleAspectFill
        
        expendStatusLb.text = "查看全部"
        expendArrowView.direct = .down
        
        seperateLine.isUserInteractionEnabled = false
        expendStatusLb.isUserInteractionEnabled = false
        expendArrowView.isUserInteractionEnabled = false
        
        // 泡泡與頭像的間距
        bubbleView.arrowLength = 5
        seperateLineOffsetConstraint?.constant = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        bubbleView.addGestureRecognizer(tap)
        
        msgContainerHeightConstraint.constant = maxHeight
        expendBtnHeightConstraint.constant = 0
        expendStatusLb.isHidden = true
        
        layer.drawsAsynchronously = true
        textLab.layer.drawsAsynchronously = true
        bubbleView.layer.drawsAsynchronously = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nickNameLab?.text = nil
        iconImageView?.image = nil
        
        expendStatusLb.isHidden = true
        expendBtnHeightConstraint?.constant = 0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        changeExpendBtnHeightIfNeed()
        changeExpendLbHiddenIfNeed()
        print(maxWidth, textLab.frame.width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changeExpendBtnHeightIfNeed()
        changeExpendLbHiddenIfNeed()
        print(maxWidth, textLab.frame.width, textLab.alignmentRectInsets)
    }
}

extension BaseChatCell {
    
    private func chatModelDidChange(to model: ChatModel) {
        switch model.type {
        case .fromSelf:
            setupForSelfTypeCell(with: model)
        case .fromOthers:
            setupForOthersTypeCell(with: model)
        }
        let text = TypesettingHelper.getAttributteString(for: model.content, with: contentFont, color: txtcolor)
        let rect = CGRect.init(origin: .zero, size: .init(width: maxWidth, height: maxHeight))
        let content = TypesettingHelper.split(text, in: rect).first
        textLab.attributedText = content
    }
    
    private func setupForSelfTypeCell(with model: ChatModel) {
        iconImageView?.image = .ct_chatCoverFromOthers2
    }
    
    private func setupForOthersTypeCell(with model: ChatModel) {
        iconImageView?.image = .ct_chatCoverFromOthers
        nickNameLab?.font = .ct_messageSenderName
    }
}

extension BaseChatCell {
    // 展開/收縮訊息
    @objc private func handleTapGesture() {
        cellDelegate?.chatTxtCell(didTapAt: self)
    }
    
    private func changeExpendLbHiddenIfNeed() {
        expendStatusLb.isHidden = expendContainerView.frame.width <= 20 + 12 + 35.5
    }
    
    private func changeExpendBtnHeightIfNeed() {
        expendBtnHeightConstraint?.constant = isExtendable ? 27 : 0
    }
    
    private func isOpenDidChanged(to isOpen: Bool, from oldValue: Bool) {
        guard isOpen != oldValue else { return }
        
        let txt = TypesettingHelper.getAttributteString(for: model.content, with: contentFont, color: txtcolor)
        if isOpen {
            textLab.attributedText = txt
            textLab.sizeToFit()
        }
        
        let height = TypesettingHelper.getContentHeight(with: txt, width: maxWidth) + (contentFont.pointSize * 2)
        
        textLab.lineBreakMode = isOpen ? .byWordWrapping : .byTruncatingTail
        msgContainerHeightConstraint.constant = isOpen ? height : maxHeight
        expendStatusLb.text = isOpen ? "收合讯息" : "查看全部"
        expendArrowView.direct = isOpen ? .up : .down
    }
}
