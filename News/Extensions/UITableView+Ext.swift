//
//  UITableView+Ext.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit

extension UITableView {
    private func indicatorView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.isHidden = false
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)) {
        indicatorView().startAnimating()
        indicatorView().isHidden = false
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 2 {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    closure()
                }
            }
        }
    }

    func stopLoading() {
        indicatorView().stopAnimating()
        indicatorView().isHidden = true
    }
    
    /// Set Empty View
    func setEmptyView(img: UIImage?, title: String, desc: String) {
        let view = BaseEmptyView()
        view.sizeToFit()
        view.img.image = img
        view.lblTitle.text = title
        view.lblDesc.text = desc
        self.backgroundView = view
    }
    
    func removeEmptyView() {
        self.backgroundView = nil
    }
}

