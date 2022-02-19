//
//  BaseVC.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit

class BaseVC: UIViewController {
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()
    
    var isLoading = false
    
    let progressView = BaseProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigation()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// remove title on back button
        navigationItem.title = " "
    }
    
    func setTitle(_ title: String, titleColor: UIColor = .darkBlue) {
        let navbar = self.navigationController?.navigationBar.frame.height ?? 0
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: navbar))
        label.textAlignment = .left
        label.text = title
        label.numberOfLines = 0
        label.textColor = titleColor
        
        let attributText = NSMutableAttributedString()
        
        let boldAttrs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        let boldAttributedString = NSMutableAttributedString(
            string: title,
            attributes: boldAttrs as [NSAttributedString.Key: Any]
        )
        
        attributText.append(boldAttributedString)
        
        label.attributedText = attributText
        navigationItem.titleView = label
    }
    
    func setNavigation(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    
    func setNavigation(barTintColor: UIColor = .white, tintColor: UIColor = .darkBlue) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.tintColor = tintColor
    }
    
    func setNavigationRightButtons(titles: [String], icons: [UIImage?]) {
        var rightButton = [UIBarButtonItem?](repeating: nil, count: titles.count)
        for i in 0 ..< rightButton.count {
            if icons.count > 0 {
                rightButton[i] = UIBarButtonItem(image: icons[i]?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(rightButtonPressed(sender:)))
                rightButton[i]?.title = titles[i]
            } else {
                rightButton[i] = UIBarButtonItem(title: titles[i], style: .plain, target: self, action: #selector(rightButtonPressed(sender:)))
            }
        }
        navigationItem.rightBarButtonItems = rightButton as? [UIBarButtonItem]
    }
    
    @objc func rightButtonPressed(sender: UIBarButtonItem) { }
    
    func setupViews() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }

    @objc func buttonPressed(_ sender: UIButton) { }
}
