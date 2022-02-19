//
//  BaseHeaderTableSectionLabelView.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit

class BaseHeaderTableSectionLabelView: UIView {
    
    let lblSection: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        v.text = "All Comment"
        v.numberOfLines = 1
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .bgSoftBlue
        addSubview(lblSection)
        
        addConstraintsWithFormat(format: "H:|-18-[v0]-18-|", views: lblSection)
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-|", views: lblSection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
