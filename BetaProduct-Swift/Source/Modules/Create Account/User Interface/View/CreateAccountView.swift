//
//  CreateAccountView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/16/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class CreateAccountView: BaseView, BaseViewProtocol, CreateAccountViewProtocol {
    @IBOutlet weak var firstNameField: BetaProductEntryField!
    @IBOutlet weak var middleNameField: BetaProductEntryField!
    @IBOutlet weak var lastNameField: BetaProductEntryField!
    @IBOutlet weak var shippingAddressField: BetaProductTextView!
    @IBOutlet weak var mobileNumberField: BetaProductEntryField!
    @IBOutlet weak var emailField: BetaProductEntryField!
    @IBOutlet weak var passwordField: BetaProductEntryField!
    @IBOutlet weak var createAccountButton: BetaProductPrimaryButton!
    @IBOutlet weak var createAccountHeader: BetaProductHeaderLabel!
    @IBOutlet weak var createAccountInstructions: BetaProductInstructionLabel!
    
    var eventHandler : CreateAccountModuleProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTheme()
        populateControls()
        enableTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTheme() {
        BetaProductTheme.current.apply()
    }
    
    func populateControls() {
        self.firstNameField.placeholder = "first name"
        self.middleNameField.placeholder = "middle name"
        self.lastNameField.placeholder = "last name"
        self.shippingAddressField.specifyPlaceHolderText(placeHolder: "shipping address")
        self.mobileNumberField.placeholder = "mobile number"
        self.emailField.placeholder = "email"
        self.passwordField.placeholder = "password"
        self.createAccountButton.setTitle("Create Account", for: .normal)
        self.firstNameField.text = ""
        self.middleNameField.text = ""
        self.lastNameField.text = ""
        self.shippingAddressField.text = ""
        self.mobileNumberField.text = ""
        self.emailField.text = ""
        self.passwordField.text = ""
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let userCredentials = UserCredentialsItem.init(lastName: lastNameField.text,
                                                       firstName: firstNameField.text,
                                                       middleName: middleNameField.text,
                                                       shippingAddress: shippingAddressField.text,
                                                       mobileNumber: mobileNumberField.text,
                                                       email: emailField.text,
                                                       password: passwordField.text)
        eventHandler?.validateUserCredentials(userCredentials)
    }
    
    func displayMessage(_ message: String, wasAccountCreationSuccesful wasSuccessful: Bool) {
        super.displayDialogMessage(withTitle: "Create Account",
                                       messageContent: message,
                                       negativeButtonCaption: "Cancel",
                                       affirmativeButtonCaption: "OK",
                                       currentViewController: self,
                                       messageStatus: wasSuccessful)
        if wasSuccessful {
            eventHandler?.proceedToLogin()
        }
    }
}
