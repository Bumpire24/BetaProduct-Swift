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
        applyCommonTheme()
        self.backgroundColor = BetaProductStyle.Colors.iDoohPink
        self.layer.borderColor = BetaProductStyle.Colors.iDoohPurple.cgColor
    }
    
    func applySecondaryButtonTheme() {
        applyCommonTheme()
        self.backgroundColor = BetaProductStyle.Colors.iDoohPurple
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func applyTertiaryButtonTheme() {
        applyCommonTheme()
        self.backgroundColor = BetaProductStyle.Colors.iDoohLightGrey
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func applyCommonTheme() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = BetaProductStyle.Colors.iDoohShadowColor.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.titleLabel?.font = BetaProductStyle.Fonts.iDoohButtonLabelFont
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
        blur.layer.cornerRadius = 10.0
        blur.isUserInteractionEnabled = false
        blur.tag = blurViewTag
        self.insertSubview(blur, at: 0)
    }
}
