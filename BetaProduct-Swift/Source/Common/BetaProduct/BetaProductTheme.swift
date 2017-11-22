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
            return BetaProductStyle.Colors.iDoohPink
        case .NonDimensional:
            return BetaProductStyle.Colors.iDoohPurple
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
            return BetaProductStyle.Colors.iDoohPink
        case .NonDimensional:
            return BetaProductStyle.Colors.iDoohPurple
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
        
        //UILabel Styles
        
        
        //TextField Styles
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).backgroundColor = UIColor.clear
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).font = BetaProductStyle.Fonts.iDoohTextfieldFont
        
        //UITextField.appearance().layer.cornerRadius = 50.0
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).layer.cornerRadius = 15.0
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).layer.borderWidth = 2.0
        UITextField.appearance(whenContainedInInstancesOf: [UIViewController.self]).layer.borderColor = UIColor.red.cgColor
        
        //Label Styles
        UILabel.appearance(whenContainedInInstancesOf: [UIViewController.self]).textColor = UIColor.white
        
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
    }
}
