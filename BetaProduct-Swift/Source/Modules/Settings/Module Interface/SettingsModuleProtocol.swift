//
//  SettingsModuleInterface.swift
//  BetaProduct-Swift
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// module interface for module `Settings`
protocol SettingsModuleProtocol {
    /// navigate to Profile Settings
    func proceedToProfileSettings()
    /// navigate to Password Settings
    func proceedToPaswordSettings()
    /// navigate to Email Settings
    func proceedToEmailSettings()
    /// log out user and navigate to login
    func logout()
}
