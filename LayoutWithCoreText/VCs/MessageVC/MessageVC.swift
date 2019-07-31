//
//  MessageVC.swift
//  LayoutWithCoreText
//
//  Created by aaron Ni on 2019/7/29.
//  Copyright © 2019 iOS＠Taipei. All rights reserved.
//

import UIKit

class MessageVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var models: [ChatModel]? {
        didSet { tableView.reloadData() }
    }
    
    private var cellOpenedIndexStorage: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        initMessages()
    }
    
    private func setupTableView() {
        tableView.register(cellType: ChatFromSelfCell.self)
        tableView.register(cellType: ChatFromOthersCell.self)
        tableView.register(cellType: UITableViewCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initMessages() {
        models = ContentFactory.getMessageModels()
    }
}

extension MessageVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models?[safe: indexPath.row] else {
            return tableView.getCell(with: UITableViewCell.self, for: indexPath)
        }
        
        let cell: BaseChatCell
        
        switch model.type {
        case .fromSelf:
            cell = tableView.getCell(with: ChatFromSelfCell.self, for: indexPath)
        case .fromOthers:
            cell = tableView.getCell(with: ChatFromOthersCell.self, for: indexPath)
        }
        
        cell.model = model
        cell.cellDelegate = self
        cell.isOpen = cellOpenedIndexStorage.contains(indexPath.row)
        return cell
    }
}

extension MessageVC: ChatTextCellDelegate {
    func chatTxtCell(didTapAt cell: BaseChatCell) {
        
        guard cell.isExtendable else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard models?[safe: indexPath.item] != nil else { return }
        
        if let index = cellOpenedIndexStorage.firstIndex(of: indexPath.item) {
            cellOpenedIndexStorage.remove(at: index)
        } else {
            cellOpenedIndexStorage.append(indexPath.item)
        }
        
        let isOutOfScreen: Bool = cell.convert(cell.bounds.origin, to: view).y < 40
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        if isOutOfScreen {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
