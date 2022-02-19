//
//  UserViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

class UserViewModel {
    
    private var user: User?
    
    init(_ user: User?) {
        self.user = user
    }
    
    var id: Int {
        return user?.id ?? 0
    }
    
    var name: String {
        return user?.name ?? ""
    }
    
    var usernanme: String {
        return user?.username ?? ""
    }
    
    var email: String {
        return user?.email ?? ""
    }

    var phone: String {
        return user?.phone ?? ""
    }
    
    var addres: String {
        let streetTemp = user?.address?.street ?? ""
        let cityTemp = user?.address?.city ?? ""
        return streetTemp + ", " + cityTemp
    }
}
