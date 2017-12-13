//
//  BaseView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class BaseView: UIViewController {
    var baseMessageView : BaseMessageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseMessageView = BaseMessageView()
        applyImageWatermark()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyGradientBackground() {
        let gradientView = UIView(frame: self.view.bounds)
        var gradientLayer: CAGradientLayer!
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [BetaProductStyle.iDoohGradientColor1.cgColor, BetaProductStyle.iDoohGradientColor2.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        self.view.insertSubview(gradientView, at: 0)
    }
    
    func applyImageWatermark() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "launchImage.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func displayDialogMessage(withTitle: String,
                              messageContent: String,
                              negativeButtonCaption: String,
                              affirmativeButtonCaption: String,
                              currentViewController: UIViewController,
                              messageStatus: Bool) {
        baseMessageView?.displayMessage(title: withTitle, message: messageContent, negativeButtonCaption: negativeButtonCaption, affirmativeButtonCaption: affirmativeButtonCaption, viewController: currentViewController, messageStatus: messageStatus)
    }
    
    func specifyFirstResponder(buttonControl : BetaProductRoundedContainerField) {
        buttonControl.becomeFirstResponder()
    }
    
    func enableTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
