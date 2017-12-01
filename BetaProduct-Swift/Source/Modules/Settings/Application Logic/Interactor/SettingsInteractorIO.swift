//
//  File.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

/// interactor input protocol for module `Settings`
protocol SettingsInteractorInput {
    /// fetches view model for display
    func getDisplayItemForProfile()
    /// log out user
    func logOut()
    /// validate and update entry with the given view model
    func validateAndUpdateSettings<T: SettingsDisplayItemProtocol>(usingDisplayitem item: T)
    /// validate and update entry with the given image data
    func validateAndUpdateSettings(usingImage image: UIImage)
}

/// base interactor output protocol for module `Settings`.
protocol SettingsInteractorOutputUpdation {
    /// delegated function callback for settings updation
    func settingsUpdationComplete<T: SettingsDisplayItemProtocol>(wasSuccessful isSuccess: Bool,
                                                                  withMessage message: String,
                                                                  withNewDisplayItem displayItem: T)
}

/// interactor output protocol for module `Settings`
protocol SettingsHomeInteractorOuput {
    /// delegated function callback for when log out is finished
    func logOutReady()
}

/// interactor output protocol for module `Settings`
protocol SettingsProfileInteractorOutput: SettingsInteractorOutputUpdation {
    /// delegated function callback for different kinds of display model following SettingsDisplayItemProtocol
    func gotDisplayItem(_ item: SettingsProfileDisplayItem)
}

/// interactor output protocol for module `Settings`
protocol SettingsEmailInteractorOutput: SettingsInteractorOutputUpdation {
}

/// interactor output protocol for module `Settings`
protocol SettingsPasswordInteractorOutput: SettingsInteractorOutputUpdation {
}

/// interactor output protocol for module `Settings`
protocol SettingsPhotoUploadInteractorOutput {
    /// delegated function callback for settings updation
    func settingsUpdationComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}
