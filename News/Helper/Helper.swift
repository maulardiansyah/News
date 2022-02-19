//
//  Helper.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation
import UIKit

public class Helper {
    
    class func checkLogin() {
        if let main = UIApplication.shared.keyWindow?.rootViewController as? MainController {
            main.checkLogin()
        } else {
            return
        }
    }
}
