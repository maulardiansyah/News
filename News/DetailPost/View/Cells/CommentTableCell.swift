//
//  CommentTableCell.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblCommennt: UILabel!
    
    static let identifier = "commentTableCell"
    static func commentTableNib() -> UINib {
        return UINib(nibName: "CommentTableCell", bundle: nil)
    }
    
    /// Set Value
    func setValue(username: String, comment: String) {
        lblUsername.text = username
        lblCommennt.text = comment
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .bgSoftBlue
    }
}
