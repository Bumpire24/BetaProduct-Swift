//
//  SettingsInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

/// interactor class for module `Settings`
class SettingsInteractor: NSObject, SettingsInteractorInput{
    /// variable for output delegate
    var outputHome: SettingsHomeInteractorOuput?
    /// variable for output delegate
    var outputProfile: SettingsProfileInteractorOutput?
    /// variable for output delegate
    var outputEmail: SettingsEmailInteractorOutput?
    /// variable for output delegate
    var outputPassword: SettingsPasswordInteractorOutput?
    /// variable for manager
    var manager: SettingsManager?
    /// variable for webservice
    var webservice: StoreWebClientProtocol?
    /// variable for session
    var session: Session?
    
    // use case
    // retrieve data from session for display
    // handles log out by emptying session
    // handles user updates WS and core data
    //  * Profile Image Update
    //  * Profile Update
    //  * Password Change With new password cofirmation
    //  * Email Change
    // check if updation is valid
    
    // MARK: SettingsInteractorInput
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func getDisplayItem<T>(forItem item: T) where T : SettingsDisplayItemProtocol {
        let user = session?.getUserSessionAsUser()
        switch item {
        case is SettingsHomeDisplayItem:
            self.outputHome?.gotDisplayItem(SettingsHomeDisplayItem(profileImageURL: user?.profileImageURL))
        case is SettingsProfileDisplayItem:
            self.outputProfile?.gotDisplayItem(SettingsProfileDisplayItem(name: user?.fullname,
                                                                          mobile: user?.mobile,
                                                                          addressShipping: user?.addressShipping,
                                                                          profileImageURL: user?.profileImageURL))
        case is SettingsEmailDisplayItem:
            self.outputEmail?.gotDisplayItem(SettingsEmailDisplayItem(emailAdd: user?.email, profileImageURL: user?.profileImageURL))
        case is SettingsPasswordDisplayItem:
            self.outputPassword?.gotDisplayItem(SettingsPasswordDisplayItem(passwordOld: "",
                                                                            passwordNew: "",
                                                                            passwordNewConfirm: "",
                                                                            profileImageURL: user?.profileImageURL))
        default: break
        }
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func validateAndUpdateSettings<T>(usingDisplayitem item: T) where T : SettingsDisplayItemProtocol {
        var user = session?.getUserSessionAsUser()
        switch item {
        case is SettingsProfileDisplayItem:
            let itemHome = item as! SettingsProfileDisplayItem
            user?.profileImageURL = itemHome.profileImageURL!
            user?.fullname = itemHome.profileImageURL!
            user?.mobile = itemHome.mobile!
            user?.addressShipping = itemHome.addressShipping!
            
            self.webservice?.PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: user?.allProperties(), block: { response in
                if response.isSuccess {
                    self.manager?.updateUser(user: user!, withCompletionBlock: { response in
                        if response.isSuccess {
                            self.outputProfile?.settingsUpdationComplete(wasSuccessful: true, withMessage: "TRUE", withNewDisplayItem: itemHome)
                        } else {
                            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "FALSE", withNewDisplayItem: itemHome)
                        }
                    })
                } else {
                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "FALSE", withNewDisplayItem: itemHome)
                }
            })
        case is SettingsEmailDisplayItem: break
        case is SettingsPasswordDisplayItem: break
        default: break
        }
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func logOut() {
        session?.user = nil
        outputHome?.logOutReady()
    }
}
