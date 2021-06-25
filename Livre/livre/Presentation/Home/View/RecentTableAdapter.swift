//
//  RecentTableAdapter.swift
//  livre
//
//  Created by 김혜빈 on 2021/06/25.
//

import UIKit

protocol RecentTableAdapterDataSource: AnyObject {
    var numberOfItems: Int { get }
    func getSearchedText(at index: Int) -> String
}

protocol RecentTableAdapterDelegate: AnyObject {
    func onClickCell(at index: Int)
}

class RecentTableAdapter: NSObject {
    weak var dataSource: RecentTableAdapterDataSource?
    weak var delegate: RecentTableAdapterDelegate?
    
    init(tableView: UITableView, dataSource: RecentTableAdapterDataSource, delegate: RecentTableAdapterDelegate) {
        super.init()
        tableView.dataSource = self
        self.dataSource = dataSource
        self.delegate = delegate
    }
}

// MARK: TableView Delegate
extension RecentTableAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RecentSearchTableCell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableCell.identifier, for: indexPath) as? RecentSearchTableCell else {
            print("recent search table cell을 불러올 수 없습니다.")
            return RecentSearchTableCell()
        }
        guard let count = dataSource?.numberOfItems else { return RecentSearchTableCell() }
        guard let searchedText = dataSource?.getSearchedText(at: (count-1) - indexPath.row) else { return RecentSearchTableCell() }
        cell.setupCellInformation(value: searchedText)
        if (indexPath.row == count) {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let count = dataSource?.numberOfItems else { return nil }
        delegate?.onClickCell(at: (count-1) - indexPath.row)
        
        return indexPath
    }
}
