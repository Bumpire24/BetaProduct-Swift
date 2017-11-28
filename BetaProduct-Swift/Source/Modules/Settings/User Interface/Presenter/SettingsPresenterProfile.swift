//
//  SettingsPresenterProfile.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class SettingsPresenterProfile: NSObject, SettingsProfileInteractorOutput {
    var interactor: SettingsInteractor?
    
    func gotDisplayItem<T>(_ item: T) where T : SettingsDisplayItemProtocol {
        
    }
    
    func settingsUpdationComplete<T>(wasSuccessful isSuccess: Bool, withMessage message: String, withNewDisplayItem displayItem: T) where T : SettingsDisplayItemProtocol {
        print("WORKED!")
    }
    
    func test() {
        interactor?.validateAndUpdateSettings(usingDisplayitem: SettingsProfileDisplayItem(name: "asd", mobile: "asd", addressShipping: "asd", profileImageURL: "asd"))
    }
}
