//
//  Button+Theme.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

let blurViewTag = 1314

extension UIButton {
    func applyPrimaryButtonTheme() {
        self.backgroundColor = BetaProductStyle.iDoohPink
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = BetaProductStyle.iDoohPurple.cgColor
        self.layer.shadowColor = BetaProductStyle.iDoohShadowColor.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func applySecondaryButtonTheme() {
        self.backgroundColor = BetaProductStyle.iDoohPurple
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowColor = BetaProductStyle.iDoohShadowColor.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func subscribeToBlurringBackground() {
        self.addTarget(self, action: #selector(onButtonRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(onButtonPressDown), for: .touchDown)
    }
    
    @objc func onButtonPressDown() {
        setupBlurBackgroundEffect()
    }
    
    @objc func onButtonRelease() {
        self.viewWithTag(blurViewTag)?.removeFromSuperview()
    }
    
    func setupBlurBackgroundEffect() {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        blur.tag = blurViewTag
        self.insertSubview(blur, at: 0)
    }
}
