//
//  LoginViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation

class LoginViewModel {
    
    private var allUser = [User]()
    
    var showError: SelectionStringClosure?
    var fetchedUser: SelectionClosure?
    
    func fetchUser(_ username: String) {
        Network.request(.login) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let allUser = try? JSONDecoder().decode([User].self, from: resData) {
                    self?.allUser = allUser
                }
            }
        }
    }
    
    private func checkAuthUser(_ username: String) {
        let userFilter = allUser.filter({ $0.username == username })
        guard userFilter.count > 1 else {
            showError?("Your username is invalid, try to check again.")
            return
        }
        
        Defaults.saveInt(userFilter.first?.id ?? 0, key: .userId)
        Defaults.saveString(userFilter.first?.name ?? "", key: .name)
        fetchedUser?()
    }
}
