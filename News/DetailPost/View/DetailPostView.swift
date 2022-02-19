//
//  DetailPostView.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit
import SkeletonView

class DetailPostView: BaseVC {

    @IBOutlet weak var tableDetailPost: UITableView!
    
    var postId = 0
    private let detailPostViewModel = DetailPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
    }
    
    // MARK: - Configure View
    internal override func setupViews() {
        super.setupViews()
        
        setTitle("Detail Post")
        tableDetailPost.contentInset = .init(top: 20, left: 0, bottom: 12, right: 0)
        tableDetailPost.register(NewsTableViewCell.postTableNib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableDetailPost.register(CommentTableCell.commentTableNib(), forCellReuseIdentifier: CommentTableCell.identifier)
        tableDetailPost.dataSource = self
        tableDetailPost.delegate = self
    }

    // MARK: - Populate Data
    private func populateData() {
        view.showGradientSkeleton()
        detailPostViewModel.populatePostDetail(postId: postId)
        detailPostViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        detailPostViewModel.fetchedComment = { [weak self] in
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.tableDetailPost.reloadData()
        }
    }
}

//MARK: - Table Data
extension DetailPostView: SkeletonTableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 else { return 1 }
        return detailPostViewModel.numberOfComment
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                fatalError("Cannot found table cell")
            }
            
            let postDetail = detailPostViewModel.viewModalPostDetail()
            cell.setValue(titlePost: postDetail?.title ?? "",
                          descPost: postDetail?.body ?? "",
                          commentCount: 0, isHiddenCommentCount: true)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableCell.identifier, for: indexPath) as? CommentTableCell else {
                fatalError("Cannot found table cell")
            }
            
            let commentPost = detailPostViewModel.viewModalComment(index: indexPath.row)
            cell.setValue(username: commentPost?.name ?? "",
                          comment: commentPost?.body ?? "")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 else { return 1 }
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard indexPath.section == 0 else { return NewsTableViewCell.identifier }
        return CommentTableCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        if indexPath.section == 1 {
            guard let cell = skeletonView.dequeueReusableCell(withIdentifier: CommentTableCell.identifier, for: indexPath) as? CommentTableCell else {
                fatalError("Cannot found table cell")
            }
            return cell
        }
        
        guard let cell = skeletonView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cannot found table cell")
        }
        return cell
    }
}

// MARK: - Table Delegate
extension DetailPostView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 1 else { return 0 }
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView,
              tableView.numberOfSections == 2 else {
            return
        }
        
        let headerHeight = tableView.rectForHeader(inSection: 1).size.height
        let offset =  max(min(0, -tableView.contentOffset.y), -headerHeight)
        tableDetailPost.contentInset = UIEdgeInsets(top: offset, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        
        let view = BaseHeaderTableSectionLabelView()
        let screen = UIScreen.main.bounds.size.width
        view.frame.size = CGSize(width: screen, height: 40)
        view.lblSection.text = "All Comment"
        return view
    }
}
