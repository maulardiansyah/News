//
//  DetailPostViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation

class DetailPostViewModel {
    
    private var allComment = [PostComment]()
    private var postDetail: Post?
    
    var showError: SelectionStringClosure?
    var fetchedComment: SelectionClosure?
    
    var numberOfComment: Int {
        return allComment.count
    }
    
    func viewModalComment(index: Int) -> PostCommentViewModel? {
        guard index < allComment.count else { return nil }
        return PostCommentViewModel(allComment[index])
    }
    
    func viewModalPostDetail() -> PostViewModel? {
        guard postDetail != nil else { return nil }
        return PostViewModel(postDetail)
    }
    
    func populatePostDetail(postId: Int) {
        getPostDetail(postId: postId)
    }
    
    private func getPostDetail(postId: Int) {
        Network.request(.detailPost(postId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let postDetail = try? JSONDecoder().decode(Post.self, from: resData) {
                    self?.postDetail = postDetail
                    self?.getCommentPost(postId: postId)
                }
            }
        }
    }
    
    private func getCommentPost(postId: Int) {
        Network.request(.getAllCommentPost(postId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listComment = try? JSONDecoder().decode([PostComment].self, from: resData) {
                    self?.allComment = listComment
                    self?.fetchedComment?()
                }
            }
        }
    }
}
