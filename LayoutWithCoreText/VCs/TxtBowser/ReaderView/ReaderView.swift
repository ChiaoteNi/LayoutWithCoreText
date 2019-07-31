//
//  ReaderView.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/28.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//
import UIKit

final class ReaderView: UIView {
    
    private var colletionView: UICollectionView!
    
    private var isLayoutedSubView: Bool = false
    private let statusBarHeight: CGFloat = 22
    private let verticalInset: CGFloat = 20
    private let horizantalInset: CGFloat = 16
    
    private var models: [NSAttributedString] = [] {
        didSet { modelsDidChange(to: models) }
    }
    
    private var font: UIFont = .systemFont(ofSize: 11)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let layout = getCVLayout()
        layout.itemSize = colletionView.frame.size
        colletionView.collectionViewLayout = layout
    }
    
    func show(txt: String, with font: UIFont, title: String = "", titleFont: UIFont) {
        self.font = font
        
        let content = title + "\n\n　　" + txt.replacingOccurrences(of: "　　", with: "\n　　")
        let style = NSMutableParagraphStyle()
        style.lineSpacing = font.pointSize / 2
        
        let attrTxt = NSMutableAttributedString.init(string: content, attributes:[.font: font, .paragraphStyle: style])
        
//        let style2 = NSMutableParagraphStyle()
//        style2.lineSpacing = 60
        let attribute: [NSAttributedString.Key: Any] = [.font: titleFont]//, .paragraphStyle: style2]
        attrTxt.setAttributes(attribute, range: .init(location: 0, length: title.count))
        
        let width: CGFloat = colletionView.frame.width - (horizantalInset * 2)
        let vertInset = (statusBarHeight + verticalInset) * 2
        let height: CGFloat = colletionView.frame.height - (font.pointSize * 2) - vertInset
        let rect: CGRect = .init(origin: .zero, size: CGSize(width: width, height: height))
        
        models = TypesettingHelper.split(attrTxt, in: rect)
    }
}

// MARK: - Private funcs.
extension ReaderView {
    
    private func setupCollectionView() {
        colletionView = UICollectionView.init(frame: .zero, collectionViewLayout: getCVLayout())
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.register(cellType: TxtCell.self)
        
        colletionView.backgroundColor = .lightGray
        colletionView.isPagingEnabled = true
        colletionView.bounces = false
        colletionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        colletionView.clipsToBounds = false
        colletionView.layer.masksToBounds = false
        colletionView.showsHorizontalScrollIndicator = false
        
        addSubview(colletionView)
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        colletionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        colletionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        colletionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func modelsDidChange(to models: [NSAttributedString]) {
        animation(duration: 0.25, delay: 0, options: .curveLinear, snapAfterUpdate: false) { [weak self] in
            self?.colletionView.reloadData()
        }
    }
    
    private func getCVLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}

extension ReaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(with: TxtCell.self, for: indexPath)
        cell.backgroundColor = backgroundColor
        
        guard let model = models[safe: indexPath.item] else { return cell }
        cell.contentLabel.attributedText = model
        cell.pageLabel.text = "\(indexPath.item + 1)/\(models.count)"
        
        return cell
    }
}

// MARK: - Operator
private func - (_ left: CGSize, _ right: CGSize) -> CGSize {
    let width = left.width - right.width
    let height = left.height - right.height
    return CGSize(width: width, height: height)
}

private func - (_ left: CGSize, _ right: UIEdgeInsets) -> CGSize {
    let width = left.width - right.right - right.left
    let height = left.height - right.top - right.bottom
    return CGSize(width: width, height: height)
}
