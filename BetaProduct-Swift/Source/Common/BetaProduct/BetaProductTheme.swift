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
            return BetaProductStyle.iDoohPink
        case .NonDimensional:
            return BetaProductStyle.iDoohPurple
        }
    }
    
    var barStyle: UIBarStyle {
        switch self {
        case .ThreeDimensional:
            return .default
        case .NonDimensional:
            return .black
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ThreeDimensional:
            return BetaProductStyle.iDoohPink
        case .NonDimensional:
            return BetaProductStyle.iDoohPurple
        }
    }
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        
        UINavigationBar.appearance().barStyle = barStyle
        //UINavigationBar.appearance().setBackgroundImage(navigationBackgroundImage, for: .default)
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        UITabBar.appearance().barStyle = barStyle
        
        UITextField.appearance().font = BetaProductStyle.iDoohTextfieldFont
        UITextField.appearance().layer.cornerRadius = 0.0
        
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
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = UIColor.white
    }
}
