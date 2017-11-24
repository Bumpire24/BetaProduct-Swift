//
//  LoginView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LoginView: BaseView, BaseViewProtocol, LoginViewProtocol {
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginHeaderLabel: BetaProductHeaderLabel!
    @IBOutlet weak var loginInstructionsLabel: BetaProductInstructionLabel!
    @IBOutlet weak var loginButton: BetaProductPrimaryButton!
    @IBOutlet weak var createAccountButton: BetaProductLinkButton!
    @IBOutlet weak var separatorButton: BetaProductLinkButton!
    @IBOutlet weak var forgotPasswordButton: BetaProductLinkButton!
    @IBOutlet weak var emailField: BetaProductEntryField!
    @IBOutlet weak var passwordField: BetaProductEntryField!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var eventHandler : LogInPresenter?

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
    
    func enableTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: LoginViewProtocol
    func displayMessage(_ message: String, isSuccessful: Bool) {
        let baseMessageView = BaseMessageView()
        baseMessageView.displayMessage(withTitle: "Login", messageContent: message, negativeButtonCaption: "Cancel", affirmativeButtonCaption: "OK", currentViewController: self, messageStatus: isSuccessful)
        
        guard isSuccessful else {
            return
        }
        
        //eventHandler?.proceedToHomeView()
    }
    
    @IBAction func login(_ sender: Any) {
        let user = UserDisplayItem.init(email: emailField.text, password: passwordField.text)
        eventHandler?.validateUser(user)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        eventHandler?.proceedToCreateAccount()
    }
}

extension LoginView {
    func setupTheme() {
        BetaProductTheme.current.apply()
    }
    
    func populateControls() {
        self.loginButton.setTitle("Login", for: .normal)
        self.forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        self.createAccountButton.setTitle("Create account", for: .normal)
        self.emailField.placeholder = "email"
        self.passwordField.placeholder = "password"
        self.emailField.text = ""
        self.passwordField.text = ""
    }
}
