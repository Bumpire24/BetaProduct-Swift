//
//  ChangePasswordView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ChangePasswordView: BaseView {
    
    @IBOutlet weak var changePasswordHeaderLabel: BetaProductHeaderLabel!
    @IBOutlet weak var changePasswordInstructionLabel: BetaProductInstructionLabel!
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var oldPasswordImageView: UIImageView!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var oldPasswordButton: UIButton!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var newPasswordImageView: UIImageView!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var newPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var changePasswordSaveButton: UIButton!
    @IBOutlet weak var changePasswordCancelButton: UIButton!
    @IBOutlet weak var changePasswordOrLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
