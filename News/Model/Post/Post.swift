//
//  Post.swift
//  News
//
//  Created by Maul on 17/02/22.
//

struct Post: Codable {
    let userId, id: Int?
    let title, body: String?
}

struct PostComment: Codable {
    let postId, id: Int?
    let name, body: String?
}
