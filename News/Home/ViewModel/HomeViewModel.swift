//
//  HomeViewModel.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import Foundation

class HomeViewModel {
    
    private var postNews = [Post]()
    private var postComment = [Int]()
    
    private var allPostNews = [Post]()
    
    private var currentIndexPagination = 9
    
    var showError: SelectionStringClosure?
    var fetchedPost: SelectionClosure?
    
    var numberOfPost: Int {
        return postNews.count
    }
    
    func getName() -> String {
        return Defaults.getString(.name)
    }
    
    func viewModelPost(index: Int) -> PostViewModel? {
        guard index < postNews.count else { return nil }
        return PostViewModel(postNews[index])
    }
    
    func getCommentCount(index: Int) -> Int {
        if index < postComment.count {
            return postComment[index]
        }
        return 0
    }
    
    func populatePost() {
        fetchPost()
    }
    
    func loadMorePost() {
        let startIndex = currentIndexPagination + 1
        currentIndexPagination += 10
        
        guard startIndex < allPostNews.count && currentIndexPagination < allPostNews.count else { return }
        let arraySlice = allPostNews[startIndex...currentIndexPagination]
        print(arraySlice.count)
        postNews.append(contentsOf: arraySlice)
        
        for index in startIndex..<postNews.count {
            fetchComment(postId: postNews[index].id ?? 0)
        }
    }
    
    private func fetchPost() {
        Network.request(.getPost) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listPost = try? JSONDecoder().decode([Post].self, from: resData) {
                    self?.allPostNews = listPost
                    let slicePost = listPost[0...self!.currentIndexPagination]
                    self?.postNews.append(contentsOf: slicePost)
                    self?.populateComment()
                }
            }
        }
    }
    
    private func populateComment() {
        for postNews in postNews {
            fetchComment(postId: postNews.id ?? 0)
        }
    }
    
    private func fetchComment(postId: Int) {
        Network.request(.getAllCommentPost(postId)) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listComment = try? JSONDecoder().decode([PostComment].self, from: resData) {
                    self?.postComment.append(listComment.count)
                    let postComment = self?.postComment.count ?? 0
                    guard postComment == self!.currentIndexPagination + 1 else { return }
                    self?.fetchedPost?()
                }
            }
        }
    }
}
