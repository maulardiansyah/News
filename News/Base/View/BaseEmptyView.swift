//
//  BaseEmptyView.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit

class BaseEmptyView: UIView {
    
    let img: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.widthAnchor.constraint(equalToConstant: 128).isActive = true
        img.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return img
    }()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = FontStyle.body(.medium).font
        label.text = "Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let lblDesc: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = FontStyle.body(.regular).font
        label.text = "Deskripsi"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let svContent: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()
    
    let svTitle: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(svContent)
        [img, svTitle].forEach { svContent.addArrangedSubview($0)}
        [lblTitle, lblDesc].forEach { svTitle.addArrangedSubview($0) }
        
        addConstraintsWithFormat(format: "V:|-(>=8)-[v0]-(>=8)-|", views: svContent)
        svContent.centerYAnchor(centerY: centerYAnchor)
        addConstraintsWithFormat(format: "H:|-(16)-[v0]-(16)-|", views: svContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
