//
//  SearchViewController+Delegate.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import UIKit

// MARK: TextField
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
        
        viewModel.requestBookItems(value: viewModel.initSearchText)
        viewModel.output.recentSearchedText.accept(text)
        clickSearchButton(searchField.button)
        return true
    }
}

// MARK: TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RecentSearchTableCell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableCell.identifier, for: indexPath) as? RecentSearchTableCell else {
            print("recent search table cell을 불러올 수 없습니다.")
            return RecentSearchTableCell()
        }
        let count = viewModel.recentSearchList.count - 1
        cell.setupCellInformation(value: viewModel.recentSearchList[count - indexPath.row])
        if (indexPath.row == count) {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let count = viewModel.recentSearchList.count - 1
        searchField.textfield.text = viewModel.recentSearchList[count - indexPath.row]
        viewModel.requestBookItems(value: viewModel.recentSearchList[count - indexPath.row])
        viewModel.output.recentSearchedText.accept(viewModel.recentSearchList[count - indexPath.row])
        clickSearchButton(searchField.button)
        self.view.endEditing(true)
        
        return indexPath
    }
}

// MARK: FavoriteCollectionView
extension SearchViewController: FavoriteCollectionDelegate {
    func removeBookData(_ item: FavoriteBook) {
        viewModel.deleteBook(item)
    }
}

// MARK: BookCard
extension SearchViewController: BookCardCellDelegate {
    func insertOrDeleteBook(_ status: Bool, _ book: Book?) {
        guard let book = book else {
            print("BookCardCell에 등록된 Book이 없어요.")
            return
        }
        if status { viewModel.insertFavorite(book) }
        else {
            if !isExistInFavorite(book.titleString) { return }
            viewModel.deleteForTitle(book.titleString)
        }
    }
    
    func isExistInFavorite(_ title: String) -> Bool {
        return viewModel.isExistInFavorite(title)
    }
    
    
    func requestTags(for text: String, _ handler: @escaping (String) -> ()) {
        viewModel.requestKeywordItems(value: text, handler: handler)
    }
}
