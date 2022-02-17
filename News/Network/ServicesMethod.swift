//
//  ServicesMethod.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import Alamofire

extension Services {
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
