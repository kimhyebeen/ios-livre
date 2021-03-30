//
//  SearchViewController+Delegate.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import Foundation

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            clickSearchButton(searchField.button)
            return true
        }
        
        vm.requestBookItems(value: text)
        clickSearchButton(searchField.button)
        return true
    }
}
