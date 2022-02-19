//
//  HomeView.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit
import SkeletonView

class HomeView: BaseVC {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tablePostView: UITableView!
    
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
    }

    // MARK: - Configure View
    internal override func setupViews() {
        super.setupViews()
        
        tablePostView.contentInset = .init(top: 16, left: 0, bottom: 12, right: 0)
        tablePostView.register(NewsTableViewCell.postTableNib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        tablePostView.dataSource = self
        tablePostView.delegate = self
    }
    
    // MARK: - Populate Data
    private func fetchPost() {
        homeViewModel.populatePost()
        homeViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        homeViewModel.fetchedPost = { [weak self] in
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.tablePostView.reloadData()
        }
    }
    
    private func loadMorePost() {
        homeViewModel.loadMorePost()
        homeViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        homeViewModel.fetchedPost = { [weak self] in
            self?.tablePostView.stopLoading()
            self?.tablePostView.reloadData()
        }
    }
}

//MARK: - Table Data
extension HomeView: SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading || homeViewModel.numberOfPost > 0 {
            tableView.removeEmptyView()
        } else {
            tableView.setEmptyView(img: UIImage(), title: "Post is empty.", desc: "")
        }
        
        return homeViewModel.numberOfPost
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cannot found table cell")
        }
        
        let post = homeViewModel.viewModelPost(index: indexPath.row)
        let commenntCount = homeViewModel.getCommentCount(index: indexPath.row)
        
        cell.setValue(titlePost: post?.title ?? "",
                      descPost: post?.body ?? "",
                      commentCount: commenntCount)
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return NewsTableViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = skeletonView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cannot found table cell")
        }
        return cell
    }
}

//MARK: - Table Delegate
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard tableView == tablePostView else  { return }
        guard homeViewModel.numberOfPost > 0 else { return }
        tableView.addLoading(indexPath) { [weak self] in
            self?.loadMorePost()
        }
    }
}
