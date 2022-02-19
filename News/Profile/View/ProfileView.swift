//
//  ProfileView.swift
//  News
//
//  Created by Maul on 19/02/22.
//

import UIKit
import SkeletonView

class ProfileView: BaseVC {
    
    @IBOutlet weak var lblUsernameValue: UILabel!
    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblEmailValue: UILabel!
    @IBOutlet weak var lblAddressValue: UILabel!
    @IBOutlet weak var lblPhoneValue: UILabel!
    
    private let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgSoftBlue
        populateUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation(isHidden: true)
    }
    
    /// Populate Data
    private func populateUser() {
        view.showGradientSkeleton()
        profileViewModel.fetchUser()
        profileViewModel.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        profileViewModel.fetchedProfile = { [weak self] in
            self?.setValue()
        }
    }
    
    private func setValue() {
        let userDetail = profileViewModel.viewModelUser()
        lblUsernameValue.text = userDetail?.usernanme
        lblNameValue.text = userDetail?.name
        lblPhoneValue.text = userDetail?.phone
        lblEmailValue.text = userDetail?.email
        lblAddressValue.text = userDetail?.addres
        
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}
