//
//  CreateAccountView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/16/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class CreateAccountView: BaseView, BaseViewProtocol, CreateAccountViewProtocol {
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var mobileNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    var eventHandler : CreateAccountPresenter?
    
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
        self.createAccountButton.applyPrimaryButtonTheme()
        self.createAccountButton.titleLabel?.font = BetaProductStyle.iDoohButtonLabelFont
        self.fullNameField.font = BetaProductStyle.iDoohTextfieldFont
        self.mobileNumberField.font = BetaProductStyle.iDoohTextfieldFont
        self.emailField.font = BetaProductStyle.iDoohTextfieldFont
        self.passwordField.font = BetaProductStyle.iDoohTextfieldFont
    }
    
    func populateControls() {
        self.fullNameField.placeholder = "Enter full name"
        self.mobileNumberField.placeholder = "Enter mobile number"
        self.emailField.placeholder = "Enter email"
        self.passwordField.placeholder = "Enter password"
        self.createAccountButton.setTitle("Create Account", for: .normal)
        self.emailField.text = ""
        self.passwordField.text = ""
    }
    
    func enableTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let userCredentials = UserCredentialsItem.init(fullName: fullNameField.text, mobileNumber: mobileNumberField.text, email: emailField.text, password: passwordField.text)
        eventHandler?.validateUserCredentials(userCredentials)
    }
    
    func displayMessage(_ message: String) {
        print(message)
    }
}
