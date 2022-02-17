//
//  Services.swift
//  News
//
//  Created by Maul on 17/02/22.
//

enum Services {
    
    /// Login
    case login
    
    /// Post
    case getPost
    case getCommentCount(_ postId: Int)
    case detailPost(_ postId: Int)
    case getAllCommentPost(_ postId: Int)
    
    /// User
    case detailUser(_ userId: Int)
}
