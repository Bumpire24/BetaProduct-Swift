//
//  BaseMessageView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class BaseMessageView: UIViewController {
    let baseMessageViewIdentifier = "BaseMessageView"

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleAndMessageView: UIView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var messageContent: UILabel!
    @IBOutlet weak var negativeButton: BetaProductDialogTertiaryButton!
    @IBOutlet weak var affirmativeButton: BetaProductDialogPrimaryButton!
    @IBOutlet weak var messageStatusImage: UIImageView!
    @IBOutlet weak var messageStatusBackgroundImage: UIImageView!
    
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
    
    func displayMessage (title : String? = "",
                         message : String? = "",
                         negativeButtonCaption : String? = "",
                         affirmativeButtonCaption : String? = "", viewController : UIViewController, messageStatus : Bool? = nil) {
        let messageProperties : Dictionary<String, String> = ["title": title!,
                                                              "message": message!,
                                                              "negativeButtonLabel": negativeButtonCaption!,
                                                              "affirmativeButtonLabel": affirmativeButtonCaption!]
        let messageViewController = viewController.storyboard?.instantiateViewController(withIdentifier: baseMessageViewIdentifier) as! BaseMessageView
        currentView = viewController
        currentView?.addChildViewController(messageViewController)
        currentView?.view.addSubview(messageViewController.view)
        populateMessageBox(messageView: messageViewController, messageProperties: messageProperties)
        
        guard messageStatus != nil else {
            return
        }
        
        let messageStatusIcon = messageStatus! ? "checkMarkBackground" : "errorBackground"
        let messageStatusBackground = messageStatus! ? "checkMarkAssocBackground" : "errorAssocBackground"
        applyThemeBasedOnMessageStatus(messageView: messageViewController, messageStatusIcon: messageStatusIcon, messageStatusBackground: messageStatusBackground)
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
    }
    
    func applyThemeBasedOnMessageStatus(messageView: BaseMessageView, messageStatusIcon: String, messageStatusBackground: String) {
        messageView.messageStatusImage.image = UIImage(named: messageStatusIcon)
        messageView.messageStatusBackgroundImage.image = UIImage(named: messageStatusBackground)
    }
    
    func applyMessageViewTheme() {
        messageView.layer.cornerRadius = 15.0
        titleAndMessageView.layer.cornerRadius = 15.0
    }
    
    func applyImageWatermark() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "checkMarkBackground.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, belowSubview: titleAndMessageView)
    }

}
