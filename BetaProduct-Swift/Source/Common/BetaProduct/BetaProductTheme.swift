//
//  BetaProductTheme.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/20/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

enum BetaProductTheme: Int {
    case ThreeDimensional, NonDimensional
    
    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }
    
    static var current: BetaProductTheme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return BetaProductTheme(rawValue: storedTheme) ?? .ThreeDimensional
    }
    
    var mainColor: UIColor {
        switch self {
        case .ThreeDimensional:
            return BetaProductStyle.iDoohPinkMainColor
        case .NonDimensional:
            return BetaProductStyle.iDoohPurpleMainColor
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .ThreeDimensional:
            return .black
        case .NonDimensional:
            return .default
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ThreeDimensional:
            return BetaProductStyle.iDoohPinkMainColor
        case .NonDimensional:
            return BetaProductStyle.iDoohPurpleMainColor
        }
    }
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        
        UINavigationBar.appearance().barStyle = barStyle
        //UINavigationBar.appearance().setBackgroundImage(navigationBackgroundImage, for: .default)
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        UITabBar.appearance().barStyle = barStyle
        
        //TextField Styles
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).backgroundColor = UIColor.clear
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).font = BetaProductStyle.Fonts.iDoohTextfieldFont
        
        //Label Styles
        UILabel.appearance(whenContainedInInstancesOf: [UIViewController.self]).textColor = BetaProductStyle.iDoohLabelFontColor
        
        //UITabBar.appearance().backgroundImage = tabBarBackgroundImage
        
//        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
//        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
//        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
//
//        let controlBackground = UIImage(named: "controlBackground")?
//            .withRenderingMode(.alwaysTemplate)
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
//
//        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
//            .withRenderingMode(.alwaysTemplate)
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
//
//        UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
//        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)
//
//        UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
//        UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
//        UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
//        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
//        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)
//
//        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
//        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
//            .resizableImage(withCapInsets:UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
//
//        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
//            .withRenderingMode(.alwaysTemplate)
//            .resizableImage(withCapInsets:UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)
//
//        UISwitch.appearance().onTintColor = mainColor.withAlphaComponent(0.3)
//        UISwitch.appearance().thumbTintColor = mainColor
//
//        UITableViewCell.appearance().backgroundColor = backgroundColor
//        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = UIColor.white
    }
}

class BetaProductHeaderLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    
    func changeFontName()
    {
        self.font = BetaProductStyle.Fonts.iDoohHeaderLabelFont
        self.textColor = BetaProductStyle.iDoohLabelFontColor
    }
}

class BetaProductInstructionLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    
    func changeFontName()
    {
        self.font = BetaProductStyle.Fonts.iDoohInstructionLabelFont
        self.textColor = BetaProductStyle.iDoohLabelFontColor
    }
}

class BetaProductSettingsLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    
    func changeFontName()
    {
        self.font = BetaProductStyle.Fonts.iDoohSettingsLabelFont
        self.textColor = BetaProductStyle.iDoohLabelFontColor
    }
}

class BetaProductEntryField : UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        applyUITheme()
    }
    
    func applyUITheme() {
        specifyFont()
        specifyBounds()
        
    }
    
    func specifyFont() {
        self.font = BetaProductStyle.Fonts.iDoohTextfieldFont
        self.textColor = BetaProductStyle.iDoohTextFieldFontColor
    }
    
    func specifyBounds() {
        self.layer.cornerRadius = 25.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = BetaProductStyle.iDoohTextFieldBorderColor.cgColor
    }
}

class BetaProductRoundedContainerField : BetaProductEntryField {
    override func awakeFromNib() {
        super.awakeFromNib()
        super.applyUITheme()
    }
    
    override func specifyBounds() {
        self.layer.borderColor = BetaProductStyle.iDoohClearBackground.cgColor
    }
}

class BetaProductButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyFont()
        specifyBounds()
    }
    
    func specifyFont() {
        self.titleLabel?.font = BetaProductStyle.Fonts.iDoohButtonLabelFont
        self.titleLabel?.textColor = BetaProductStyle.iDoohButtonFontColor
    }
    
    func specifyBounds() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.borderWidth = 1.0
    }
}

class BetaProductPrimaryButton : BetaProductButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyFillColor()
    }
    
    func specifyFillColor() {
        self.backgroundColor = BetaProductStyle.iDoohPrimaryButtonBackgroundColor
        self.layer.borderColor = BetaProductStyle.iDoohPrimaryButtonBorderColor.cgColor
        self.titleLabel?.textColor = BetaProductStyle.iDoohLabelFontColor
    }
}

protocol BetaProductDialogButton {
    func specifyButtonShadow()
}

class BetaProductDialogPrimaryButton : BetaProductPrimaryButton, BetaProductDialogButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyButtonShadow()
    }
    
    func specifyButtonShadow() {
        specifyDialogButtonShadow(buttonControl: self)
    }
}

class BetaProductSecondaryButton : BetaProductButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyFillColor()
    }
    
    func specifyFillColor() {
        self.backgroundColor = BetaProductStyle.iDoohSecondaryButtonBackgroundColor
        self.layer.borderColor = BetaProductStyle.iDoohSecondaryButtonBorderColor.cgColor
    }
}

class BetaProductDialogSecondaryButton : BetaProductSecondaryButton, BetaProductDialogButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyButtonShadow()
    }
    
    func specifyButtonShadow() {
        specifyDialogButtonShadow(buttonControl: self)
    }
}

class BetaProductTertiaryButton : BetaProductButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyFillColor()
    }
    
    func specifyFillColor() {
        self.backgroundColor = BetaProductStyle.iDoohTertiaryButtonBackgroundColor
        self.layer.borderColor = BetaProductStyle.iDoohTertiaryButtonBorderColor.cgColor
    }
}

class BetaProductDialogTertiaryButton : BetaProductTertiaryButton, BetaProductDialogButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyButtonShadow()
    }
    
    func specifyButtonShadow() {
        specifyDialogButtonShadow(buttonControl: self)
    }
}

class BetaProductLinkButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyFont()
        specifyFillColor()
    }
    
    func specifyFont() {
        self.titleLabel?.font = BetaProductStyle.Fonts.iDoohButtonLabelFont
        self.titleLabel?.textColor = BetaProductStyle.iDoohLinkButtonFontColor
    }
    
    func specifyFillColor() {
        self.backgroundColor = BetaProductStyle.iDoohClearBackground
    }
}

class BetaProductRoundedContainerView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        specifyBorderProperty()
    }
    
    func specifyBorderProperty() {
        self.layer.borderColor = BetaProductStyle.iDoohTextFieldBorderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.backgroundColor = BetaProductStyle.iDoohClearBackground.cgColor
        self.layer.cornerRadius = 25.0
    }
}

fileprivate func specifyDialogButtonShadow(buttonControl: UIButton) {
    buttonControl.layer.borderColor = BetaProductStyle.iDoohClearBackground.cgColor
    buttonControl.layer.shadowColor = BetaProductStyle.iDoohMessageViewShadowColor.cgColor
    buttonControl.layer.shadowOpacity = 1.0
    buttonControl.layer.shadowRadius = 3.0
    buttonControl.layer.shadowOffset = CGSize(width: 0, height: 3)
}
