//
//  NewsTableViewCell.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerContent: UIView!
    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var descPostLabel: UILabel!
    @IBOutlet weak var commentCountButton: UIButton!
    
    static let identifier = "postTableCell"
    static func postTableNib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }

    /// Set Value
    func setValue(titlePost: String, descPost: String, commentCount: Int) {
        titlePostLabel.text = titlePost
        descPostLabel.text = descPost
        commentCountButton.setTitle("\(commentCount)", for: .normal)
    }
    
    //MARK: - Configure View
    override func layoutSubviews() {
        setupViews()
    }
    
    private func setupViews() {
        containerContent.layer.cornerRadius = 8
        containerContent.layer.borderColor = UIColor.gray.cgColor
        containerContent.layer.borderWidth = 0.8
        
        commentCountButton.titleEdgeInsets.left = 8
        contentView.backgroundColor = .bgSoftBlue
    }
}
