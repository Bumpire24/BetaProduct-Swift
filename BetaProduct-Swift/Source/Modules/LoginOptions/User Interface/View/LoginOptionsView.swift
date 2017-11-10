//
//  LoginOptionsView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LoginOptionsView: BaseView {
    @IBOutlet var loginOptionsView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var iDoohImageView: UIImageView!
    @IBOutlet weak var dbsImageView: UIImageView!
    var eventHandler : LoginOptionsModuleInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTheme()
        populateControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTheme() {
        self.loginButton.backgroundColor = BetaProductStyle.iDoohClearColor
        self.loginButton.subscribeToBlurringBackground()
        self.createAccountButton.backgroundColor = BetaProductStyle.iDoohClearColor
        self.createAccountButton.subscribeToBlurringBackground()
        self.loginButton.titleLabel?.font = BetaProductStyle.iDoohButtonLabelFont
        self.createAccountButton.titleLabel?.font = BetaProductStyle.iDoohButtonLabelFont
    }
    
    func populateControls() {
        self.iDoohImageView.image = UIImage(named: "iDooh")
        self.dbsImageView.image = UIImage(named: "dbsPaylah")
        self.loginButton.setTitle("Login", for: .normal)
        self.createAccountButton.setTitle("Create account", for: .normal)
    }
    
    @IBAction func proceedToLogin(_ sender: Any) {
        eventHandler?.login()
    }
}
