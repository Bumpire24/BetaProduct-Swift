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
    weak var currentViewController : UIViewController?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
        self.currentViewController = currentViewController
        let viewcontroller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: baseMessageViewIdentifier) as! BaseMessageView
        self.currentViewController?.navigationController?.present(viewcontroller, animated: true, completion: nil)
        populateMessageBox(messageView: viewcontroller, messageProperties: messageProperties)
    }
    
    @IBAction func affirmationAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func negationAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateMessageBox(messageView: BaseMessageView, messageProperties: Dictionary<String, String>) {
        messageView.messageTitleText = messageProperties["title"]!
        messageView.messageContentText = messageProperties["message"]!
        messageView.negativeButtonText = messageProperties["negativeButtonLabel"]!
        messageView.affirmativeButtonText = messageProperties["affirmativeButtonLabel"]!
    }
}
