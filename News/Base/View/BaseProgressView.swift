//
//  BaseProgressView.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit

class BaseProgressView {
    
    let container: UIView = {
        let view = UIView()
        return view
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        return indicatorView
    }()
    
    public func show(view: UIView, backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.7), style : UIActivityIndicatorView.Style = .whiteLarge) {
        view.addSubview(container)
        container.backgroundColor = backgroundColor
        container.anchorSize(to: view)
        
        setupIndicator(style)
    }
    
    private func setupIndicator(_ style: UIActivityIndicatorView.Style, _ color: UIColor = .darkBlue) {
        indicator.style = style
        indicator.color = color
        indicator.startAnimating()
        container.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(centerX: container.centerXAnchor)
        indicator.centerYAnchor(centerY: container.centerYAnchor)
        indicator.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }
    
    public func hide() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        container.removeFromSuperview()
    }
}
