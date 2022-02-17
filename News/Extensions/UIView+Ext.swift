//
//  UIView+Ext.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit
import Toast_Swift

extension UIView {
    /// To show toast view
    func showToast(_ message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom, bgColor: UIColor = UIColor.black.withAlphaComponent(0.8)) {
        var style = ToastStyle()
        style.backgroundColor = bgColor
        self.makeToast(message, duration: duration, position: position, style: style)
    }
    
    //MARK: - For set constraints
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        self.anchor(top: self.superview?.topAnchor, bottom: self.superview?.bottomAnchor, leading: self.superview?.leadingAnchor, trailing: self.superview?.trailingAnchor, padding: padding)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        }
        if let bottomAnchor = bottom {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
        }
        if let leadingAnchor = leading {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        }
        if let trailingAnchor = trailing {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerYAnchor(centerY: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    func centerXAnchor(centerX: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
    }
    
    func anchorSize(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
