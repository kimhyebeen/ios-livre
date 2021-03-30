//
//  SearchViewController+Delegate.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import UIKit

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.recentSearchTable.reloadData()
        self.recentSearchTable.isHidden = false
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.recentSearchTable.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        if text.isEmpty {
            self.showToast(view: self.view, message: "검색어를 입력해주세요.")
            return true
        }
        
        vm.requestBookItems(value: text)
        clickSearchButton(searchField.button)
        return true
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RecentSearchTableCell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableCell.identifier, for: indexPath) as? RecentSearchTableCell else {
            print("recent search table cell을 불러올 수 없습니다.")
            return RecentSearchTableCell()
        }
        let count = recentSearchList.count - 1
        cell.setupCellInformation(value: recentSearchList[count - indexPath.row])
        if (indexPath.row == count) {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let count = recentSearchList.count - 1
        searchField.textfield.text = recentSearchList[count - indexPath.row]
        vm.requestBookItems(value: recentSearchList[count - indexPath.row])
        clickSearchButton(searchField.button)
        self.view.endEditing(true)
        
        return indexPath
    }
}
