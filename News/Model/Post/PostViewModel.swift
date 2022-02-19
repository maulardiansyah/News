//
//  PostViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

class PostViewModel {
    
    private var post: Post?
    
    init(_ post: Post?) {
        self.post = post
    }
    
    var userId: Int {
        return post?.userId ?? 0
    }
    
    var id: Int {
        return post?.id ?? 0
    }
    
    var title: String {
        return post?.title ?? ""
    }
    
    var body: String {
        return post?.body ?? ""
    }
}

class PostCommentViewModel {
    
    private var postComment: PostComment?
    
    init(_ postComment: PostComment?) {
        self.postComment = postComment
    }
    
    var postId: Int {
        return postComment?.postId ?? 0
    }
    
    var id: Int {
        return postComment?.id ?? 0
    }
    
    var name: String {
        return postComment?.name ?? ""
    }
    
    var body: String {
        return postComment?.body ?? ""
    }
}
