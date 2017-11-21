//
//  BaseMessageView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class BaseMessageView: BaseView {
    let baseMessageViewIdentifier = "BaseMessageView"

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleAndMessageView: UIView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var messageContent: UILabel!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var affirmativeButton: UIButton!
    weak var currentView : UIViewController?
    
    var messageTitleText : String {
        get {
            return messageTitle.text ?? ""
        }
        set(messageTitleString) {
            messageTitle?.text = messageTitleString
        }
    }
    
    var messageContentText : String {
        get {
            return messageContent.text ?? ""
        }
        set(messageContentString) {
            messageContent?.text = messageContentString
        }
    }
    
    var negativeButtonText : String {
        get {
            return negativeButton.titleLabel?.text ?? ""
        }
        set(negativeButtonCaption) {
            negativeButton?.setTitle(negativeButtonCaption, for: .normal)
        }
    }
    
    var affirmativeButtonText : String {
        get {
            return affirmativeButton.titleLabel?.text ?? ""
        }
        set(affirmativeButtonCaption) {
            affirmativeButton?.setTitle(affirmativeButtonCaption, for: .normal)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMessage (withTitle : String? = "",
                         messageContent : String? = "",
                         negativeButtonCaption : String? = "",
                         affirmativeButtonCaption : String? = "", currentViewController : UIViewController) {
        let messageProperties : Dictionary<String, String> = ["title": withTitle!,
                                                              "message": messageContent!,
                                                              "negativeButtonLabel": negativeButtonCaption!,
                                                              "affirmativeButtonLabel": affirmativeButtonCaption!]
        let messageViewController = currentViewController.storyboard?.instantiateViewController(withIdentifier: baseMessageViewIdentifier) as! BaseMessageView
        currentView = currentViewController
        currentView?.addChildViewController(messageViewController)
        currentView?.view.addSubview(messageViewController.view)
        populateMessageBox(messageView: messageViewController, messageProperties: messageProperties)
    }
    
    @IBAction func affirmationAction(_ sender: Any) {
        discardMessageView()
    }
    
    @IBAction func negationAction(_ sender: Any) {
        discardMessageView()
    }
    
    func discardMessageView() {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    func populateMessageBox(messageView: BaseMessageView, messageProperties: Dictionary<String, String>) {
        messageView.messageTitleText = messageProperties["title"]!
        messageView.messageContentText = messageProperties["message"]!
        messageView.negativeButtonText = messageProperties["negativeButtonLabel"]!
        messageView.affirmativeButtonText = messageProperties["affirmativeButtonLabel"]!
    }
    
    func applyTheme() {
        applyMessageViewTheme()
        affirmativeButton.applyPrimaryButtonTheme()
        negativeButton.applyTertiaryButtonTheme()
    }
    
    func applyMessageViewTheme() {
        messageView.layer.cornerRadius = 15.0
        titleAndMessageView.layer.cornerRadius = 15.0
        messageView.layer.borderColor = BetaProductStyle.iDoohPurple.cgColor
        messageView.layer.shadowColor = BetaProductStyle.iDoohShadowColor.cgColor
        messageView.layer.shadowOpacity = 1.0
        messageView.layer.shadowRadius = 3.0
        messageView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

}
