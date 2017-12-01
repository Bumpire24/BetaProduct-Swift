//
//  SettingsPresenterProfile.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

/// presenter class for module `Settings`
class SettingsPresenterProfile: NSObject, SettingsUpdateModuleProtocol, SettingsProfileInteractorOutput {
    /// variable for interactor
    var interactor: SettingsInteractorInput?
    /// variable for wireframe
    var wireframe: String?
    /// variable for view
    var view: String?
    
    // MARK: SettingsProfileInteractorOutput
    /// implements protocol. see `SettingsInteractorIO.swift`
    func gotDisplayItem<T>(_ item: T) where T : SettingsDisplayItemProtocol {
        
    }
    
    /// implements protocol. see `SettingsInteractorIO.swift`
    func settingsUpdationComplete<T>(wasSuccessful isSuccess: Bool, withMessage message: String, withNewDisplayItem displayItem: T?) where T : SettingsDisplayItemProtocol {
        
    }
    
    // MARK: SettingsUpdateModuleProtocol
    /// implements protocol. see `SettingsModuleProtocols.swift`
    func saveUpdates<T>(withItem item: T) where T : SettingsDisplayItemProtocol {
        self.interactor?.validateAndUpdateSettings(usingDisplayitem: item)
    }
    
    /// implements protocol. see `SettingsModuleProtocols.swift`
    func cancelUpdates() {
        
    }
    
    /// implements protocol. see `SettingsModuleProtocols.swift`
    func updateView() {
        self.interactor?.getDisplayItemForProfile()
    }
}
