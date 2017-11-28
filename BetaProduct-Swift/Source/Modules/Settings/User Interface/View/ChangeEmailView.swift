//
//  ChangeEmailView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ChangeEmailView: BaseView {

    @IBOutlet weak var changeEmailHeaderLabel: BetaProductHeaderLabel!
    @IBOutlet weak var changeEmailInstructionLabel: BetaProductInstructionLabel!
    @IBOutlet weak var oldEmailAddressView: UIView!
    @IBOutlet weak var oldEmailImageView: UIImageView!
    @IBOutlet weak var oldEmailAddressField: UITextField!
    @IBOutlet weak var oldEmailAddressButton: UIButton!
    @IBOutlet weak var newEmailAddressView: UIView!
    @IBOutlet weak var newEmailImageView: UIImageView!
    @IBOutlet weak var newEmailAddressField: UITextField!
    @IBOutlet weak var newEmailAddressButton: UIButton!
    @IBOutlet weak var confirmEmailAddressView: UIView!
    @IBOutlet weak var confirmEmailImageView: UIImageView!
    @IBOutlet weak var confirmEmailAddressField: UITextField!
    @IBOutlet weak var confirmEmailAddressButton: UIButton!
    @IBOutlet weak var changeEmailAddressSaveButton: UIButton!
    @IBOutlet weak var changeEmailAddressCancelButton: UIButton!
    @IBOutlet weak var changeEmailOrLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
