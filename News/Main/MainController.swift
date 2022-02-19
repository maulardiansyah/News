//
//  ViewController.swift
//  News
//
//  Created by Maul on 17/02/22.
//

import UIKit

class MainController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkLogin()
    }
    
    public func checkLogin() {
        print(#function)
        if Defaults.getInt(.userId) != 0 {
            viewControllers = [MainTabbarController()]
        } else {
            /// untuk dismiss view is presented
            dismiss(animated: true, completion: nil)
            perform(#selector(toLoginView), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc func toLoginView() {
        let login = UINavigationController(rootViewController: LoginView())
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
    }
}

