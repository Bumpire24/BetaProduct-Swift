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
    @IBOutlet weak var iDoohImageView: UIImageView!
    @IBOutlet weak var dbsImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
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
    
    func setupTheme() {
        self.loginButton.applyPrimaryButtonTheme()
        self.forgotPasswordButton.backgroundColor = BetaProductStyle.iDoohClearColor
        self.forgotPasswordButton.setTitleColor(BetaProductStyle.iDoohLinkColor, for: .normal)
        self.emailField.layer.cornerRadius = 5.0
        self.passwordField.layer.cornerRadius = 5.0
    }

    func populateControls() {
        self.iDoohImageView.image = UIImage(named: "iDooh")
        self.dbsImageView.image = UIImage(named: "dbsPaylah")
        self.loginButton.setTitle("Login", for: .normal)
        self.forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        self.emailField.placeholder = "Enter email"
        self.passwordField.placeholder = "Enter password"
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
    
    // MARK: LoginViewProtocol
    func displayMessage(_ message: String) {
        let baseMessageView = BaseMessageView()
        baseMessageView.displayMessage(withTitle: "Login", messageContent: message, negativeButtonCaption: "Cancel", affirmativeButtonCaption: "OK", currentViewController: self)
        print(message)
        eventHandler?.proceedToHomeView()
    }
    
    @IBAction func login(_ sender: Any) {
        let user = UserDisplayItem.init(username: emailField.text, password: passwordField.text)
        eventHandler?.validateUser(user)
    }
}
