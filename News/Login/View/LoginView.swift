//
//  LoginView.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit

class LoginView: BaseVC {

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure View
    internal override func setupViews() {
        super.setupViews()
        
        [textFieldUsername, textFieldPassword].forEach {
            $0?.layer.borderColor = UIColor.blue.cgColor
        }
        buttonLogin.layer.cornerRadius = 8
    }
    
    @IBAction func buttonLoginPressed(_ sender: Any) {
        let usernameTemp = textFieldUsername.text ?? ""
        let passwordTemp = textFieldPassword.text ?? ""
        guard usernameTemp != "" && passwordTemp != "" else {
            view.showToast("Check again your username and password input not for all is fill.")
            return
        }
        
        progressView.show(view: view)
        loginViewModel.fetchUser(usernameTemp)
        loginViewModel.showError = { [weak self] message in
            self?.view.showToast(message)
        }
        loginViewModel.fetchedUser = { [weak self] in
            self?.progressView.hide()
        }
    }
}
