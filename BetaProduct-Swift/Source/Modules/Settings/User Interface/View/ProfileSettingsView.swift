//
//  ProfileSettingsView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProfileSettingsView: BaseView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var fullNameImage: UIImageView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var fullNameButton: UIButton!
    @IBOutlet weak var billingAddressView: UIView!
    @IBOutlet weak var billingAddressImage: UIImageView!
    @IBOutlet weak var billingAddressField: UITextField!
    @IBOutlet weak var billingAddressButton: UIButton!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var mobileNumberImage: UIImageView!
    @IBOutlet weak var mobileNumberField: UITextField!
    @IBOutlet weak var mobileNumberButton: UIButton!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var cancelProfileButton: UIButton!
    @IBOutlet weak var profileVisualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
