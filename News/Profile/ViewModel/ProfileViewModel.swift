//
//  ProfileViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation

class ProfileViewModel {
    
    private var userDetail: User?
    
    var showError: SelectionStringClosure?
    var fetchedProfile: SelectionClosure?
    
    func viewModelUser() -> UserViewModel? {
        guard userDetail != nil else { return nil }
        return UserViewModel(userDetail)
    }
    
    func fetchUser() {
        Network.request(.detailUser(Defaults.getInt(.userId))) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let user = try? JSONDecoder().decode(User.self, from: resData) {
                    self?.userDetail = user
                    self?.fetchedProfile?()
                }
            }
        }
    }
}
