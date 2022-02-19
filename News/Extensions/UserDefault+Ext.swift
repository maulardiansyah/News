//
//  UserDefault+Ext.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation

enum KeyDefaults: String {
    
    case userId
    case name
}

struct Defaults {
    
    static func saveString(_ string: String, key: KeyDefaults) {
        UserDefaults.standard.set(string, forKey: key.rawValue)
    }
    
    static func saveInt(_ int: Int, key: KeyDefaults) {
        UserDefaults.standard.set(int, forKey: key.rawValue)
    }
    
    static func getInt(_ key: KeyDefaults) -> Int {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func getString(_ key: KeyDefaults) -> String {
        UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
}
