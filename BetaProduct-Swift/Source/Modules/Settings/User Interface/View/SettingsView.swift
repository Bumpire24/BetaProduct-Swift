//
//  SettingsView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class SettingsView: BaseView {

    @IBOutlet weak var userSettingsHeader: BetaProductHeaderLabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: BetaProductSettingsLabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var changeEmailView: UIView!
    @IBOutlet weak var emailView: UIImageView!
    @IBOutlet weak var changeEmailLabel: BetaProductSettingsLabel!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var changePasswordImage: UIImageView!
    @IBOutlet weak var changePasswordLabel: BetaProductSettingsLabel!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var logoutImage: UIImageView!
    @IBOutlet weak var logoutLabel: BetaProductSettingsLabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
