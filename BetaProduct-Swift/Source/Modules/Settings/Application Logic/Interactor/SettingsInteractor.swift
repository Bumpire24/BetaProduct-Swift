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
    /// variable for output delegate
    var outputPhotoUpload: SettingsPhotoUploadInteractorOutput?
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
    // provide new update and update display
    
    // MARK: SettingsInteractorInput
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func getDisplayItemForProfile() {
        self.outputProfile?.gotDisplayItem(makeSettingsProfileDisplayItemFromSession())
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func validateAndUpdateSettings<T>(usingDisplayitem item: T) where T : SettingsDisplayItemProtocol {
        var user = session?.getUserSessionAsUser()
        switch item {
        case is SettingsProfileDisplayItem:
            let itemHome = item as! SettingsProfileDisplayItem
            user?.fullname = itemHome.name!
            user?.mobile = itemHome.mobile!
            user?.addressShipping = itemHome.addressShipping!
            
            itemHome == makeSettingsProfileDisplayItemFromSession()
            
            if let image = itemHome.profileImage.image {
                webservice?.UploadImage(asData: UIImagePNGRepresentation(image)!, toURL: BetaProduct.kBPWSPostUserImage, WithCompletionBlock: { response in
                    switch response {
                    case .success(_):
                        self.callWSAndUpdateUser(user!, updateDisplayItem: itemHome, processedPhotoUpload: true)
                    case .failure(_):
                        self.callWSAndUpdateUser(user!, updateDisplayItem: itemHome, processedPhotoUpload: false)
                    }
                })
            } else {
                self.callWSAndUpdateUser(user!, updateDisplayItem: itemHome)
            }
            
        case is SettingsEmailDisplayItem: break
        case is SettingsPasswordDisplayItem: break
        default: break
        }
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func validateAndUpdateSettings(usingImage image: UIImage) {
        webservice?.UploadImage(asData: UIImagePNGRepresentation(image)!, toURL: BetaProduct.kBPWSPostUserImage, WithCompletionBlock: { response in
            switch response {
            case .success(_):
                self.outputPhotoUpload?.settingsUpdationComplete(wasSuccessful: true, withMessage: "Successfully uploaded Image!")
            case .failure(let error):
                self.outputPhotoUpload?.settingsUpdationComplete(wasSuccessful: false, withMessage: (error?.localizedFailureReason)!)
            }
        })
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func logOut() {
        session?.user = nil
        outputHome?.logOutReady()
    }
    
    // MARK: Privates
    private func callWSAndUpdateUser(_ user: User, updateDisplayItem item: SettingsProfileDisplayItem, processedPhotoUpload photoUploadWasGood: Bool? = nil) {
        var wasSuccessful = false
        var messageResponse = ""
        
        self.webservice?.PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: user.allProperties(), block: { response in
            switch response {
            case .success(_):
                self.manager?.updateUser(user: user, withCompletionBlock: { response in
                    if response.isSuccess {
                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: true, withMessage: "TRUE", withNewDisplayItem: item)
                    } else {
                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "FALSE", withNewDisplayItem: item)
                    }
                })
            case .failure(_):
                wasSuccessful = photoUploadWasGood != nil || false
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: wasSuccessful, withMessage: "FALSE", withNewDisplayItem: item)
            }
        })
    }
    
    private func makeSettingsProfileDisplayItemFromSession() ->  SettingsProfileDisplayItem{
        let user = session?.getUserSessionAsUser()
        return SettingsProfileDisplayItem(name: user?.fullname,
                                          mobile: user?.mobile,
                                          addressShipping: user?.addressShipping,
                                          profileImage: (url: user?.profileImageURL, image: nil))
    }
}
