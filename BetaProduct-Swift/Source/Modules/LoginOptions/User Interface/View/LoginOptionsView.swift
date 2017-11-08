//
//  LoginOptionsView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LoginOptionsView: UIViewController {
    @IBOutlet var loginOptionsView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var iDoohImageView: UIImageView!
    @IBOutlet weak var dbsImageView: UIImageView!
    
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
        self.loginOptionsView.backgroundColor = BetaProductStyle.iDoohPurple
        self.loginButton.backgroundColor = BetaProductStyle.iDoohPink
        self.createAccountButton.backgroundColor = BetaProductStyle.iDoohPink
        self.loginButton.titleLabel?.font = BetaProductStyle.iDoohHelveticaButtonLabel
        self.createAccountButton.titleLabel?.font = BetaProductStyle.iDoohHelveticaButtonLabel
    }
    
    func populateControls() {
        self.iDoohImageView.image = UIImage(named: "iDooh")
        self.dbsImageView.image = UIImage(named: "dbsPaylah")
        self.loginButton.setTitle("Login", for: .normal)
        self.createAccountButton.setTitle("Create account", for: .normal)
    }
}
