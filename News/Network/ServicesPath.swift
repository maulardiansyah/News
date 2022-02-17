//
//  ServicesPath.swift
//  News
//
//  Created by Maul on 17/02/22.
//

extension Services {
    
    var path: String {
        switch self {
    /// Login
        case .login:
            return "/users"
            
    /// Post
        case .getPost:
            return "/posts"
        case .detailPost(let postId):
            return "/posts/\(postId)"
        case .getAllCommentPost(let postId):
            return "/posts/\(postId)/comments"
            
    /// User
        case .detailUser(let userId):
            return "/users/\(userId)"
        }
    }
}
