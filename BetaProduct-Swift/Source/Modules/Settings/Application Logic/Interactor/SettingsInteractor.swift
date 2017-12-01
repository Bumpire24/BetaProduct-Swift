//
//  SettingsInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import CocoaLumberjack

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
    // provide new update and update display
    
    // MARK: SettingsInteractorInput
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func getDisplayItemForProfile() {
        self.outputProfile?.gotDisplayItem(makeSettingsProfileDisplayItemFromSession())
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func validateAndUpdateSettings<T>(usingDisplayitem item: T) where T : SettingsDisplayItemProtocol {
        switch item {
        case is SettingsProfileDisplayItem:
            let itemHome = item as! SettingsProfileDisplayItem
            validateAndUpdateProfile(itemHome)
        case is SettingsEmailDisplayItem:
            let itemEmail = item as! SettingsEmailDisplayItem
            validateAndUpdateEmail(itemEmail)
        case is SettingsPasswordDisplayItem:
            let itemPass = item as! SettingsPasswordDisplayItem
            validateAndUpdatePassword(itemPass)
        default: break
        }
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func logOut() {
        session?.dismissCurrentUser()
        outputHome?.logOutReady()
    }
    
    // MARK: Privates
    // calls Webservice and updates local data
    private func callWSAndUpdateUser(_ user: User, updateDisplayItem item: SettingsDisplayItemProtocol, processedPhotoUpload photoUploadWasGood: Bool? = nil) {
        var photoGood = false
        var message = ""
        // Check if there was a photo upload
        if let wasSuccessful = photoUploadWasGood {
            photoGood = wasSuccessful || photoGood
            if wasSuccessful {
                message = "Photo Upload was successful!"
            } else {
                message = "Photo Upload failed"
            }
        }
        
        self.webservice?.PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: user.allProperties(), block: { response in
            switch response {
            case .success(let value):
                self.manager?.updateUser(user: user, withCompletionBlock: { response in
                    switch response {
                    case .success(_):
                        // Set new Session
                        if let list = value, let targetUser = list.first, let converted = targetUser as? [String:Any] {
                            let updatedUser = User.init(dictionary: converted)
                            self.session?.setUserSessionByUser(updatedUser)
                        } else {
                            // failed to convert User
                            DDLogError("Error  description : User conversion failure. reason : Failed to convert Dictionary to Session. suggestion : Debug function \(#function)")
                        }
                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || true,
                                                                     withMessage: "Profile Update was successful! " + message,
                                                                     withNewDisplayItem: item as? SettingsProfileDisplayItem)
                    case .failure(let error):
                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || false,
                                                                     withMessage: message + " " + (error?.localizedDescription)!,
                                                                     withNewDisplayItem: item as? SettingsProfileDisplayItem)
                    }
                })
            case .failure(let error):
                if photoUploadWasGood != nil {
                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || false,
                                                                 withMessage: message + " " + (error?.localizedDescription)!,
                                                                 withNewDisplayItem: item as? SettingsProfileDisplayItem)
                } else {
                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: false,
                                                                 withMessage: (error?.localizedDescription)!,
                                                                 withNewDisplayItem: nil as SettingsProfileDisplayItem?)
                }
            }
        })
    }
    
    /// creates a SettingsProfileDisplayItem from User Session
    private func makeSettingsProfileDisplayItemFromSession() ->  SettingsProfileDisplayItem{
        let user = session?.getUserSessionAsUser()
        return SettingsProfileDisplayItem(name: user?.fullname,
                                          mobile: user?.mobile,
                                          addressShipping: user?.addressShipping,
                                          profileImage: (url: user?.profileImageURL, image: nil))
    }
    
    /// validates Email Update
    private func validateAndUpdateEmail(_ item: SettingsEmailDisplayItem) {
        // check if values are nil, empty strings or valid
        guard let emailOld = item.emailAddOld?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: emailOld) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Old Email Address Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        guard let emailNew = item.emailAddNew?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: emailNew) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Email Address Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        guard let emailNewC = item.emailAddNewConfirm?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: emailNewC) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Confirm New Email Address Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        var user = session?.getUserSessionAsUser()
        if emailOld != user?.email {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Email does not match your Current Email", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        if emailNew != emailNewC {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Email and Confirm New Email does not match", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        user?.email = item.emailAddNew!
        self.callWSAndUpdateUser(user!, updateDisplayItem: item)
    }
    
    /// validates Password Update
    private func validateAndUpdatePassword(_ item: SettingsPasswordDisplayItem) {
        guard let passOld = item.passwordOld?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passOld) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Old Password Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        guard let passNew = item.passwordNew?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passNew) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Password Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        guard let passNewC = item.passwordNewConfirm?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passNewC) else {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Confirm New Password Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        var user = session?.getUserSessionAsUser()
        if passOld != user?.password {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Password does not match your Current Password", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        if passNew != passNew {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Password and Confirm New Password does not match", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
            return
        }
        
        user?.password = item.passwordNew!
        self.callWSAndUpdateUser(user!, updateDisplayItem: item)
    }
    
    /// validates Profile Update
    private func validateAndUpdateProfile(_ item: SettingsProfileDisplayItem) {
        // check if items are not equal
        if item == makeSettingsProfileDisplayItemFromSession() {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "No changes found for Profile!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
        } else {
            // check if values are nil, empty strings or valid
            guard let name = item.name?.trimmingCharacters(in: .whitespacesAndNewlines), isNameValid(name: name) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Name Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
                return
            }
            
            guard let mobile = item.mobile?.trimmingCharacters(in: .whitespacesAndNewlines), isMobileValid(mobile: mobile) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Mobile Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
                return
            }
            
            guard let address = item.addressShipping?.trimmingCharacters(in: .whitespacesAndNewlines), isAddressValid(address: address) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Address Incorrect!", withNewDisplayItem: nil as SettingsProfileDisplayItem?)
                return
            }
            
            var user = session?.getUserSessionAsUser()
            user?.fullname = item.name!
            user?.mobile = item.mobile!
            user?.addressShipping = item.addressShipping!
            if let image = item.profileImage.image {
                webservice?.UploadImage(asData: UIImagePNGRepresentation(image)!, toURL: BetaProduct.kBPWSPostUserImage, WithCompletionBlock: { response in
                    switch response {
                    case .success(_):
                        // tempo image
                        var itemProfile = item
                        itemProfile.profileImage.url = "http://placehold.it/600/92c952"
                        self.callWSAndUpdateUser(user!, updateDisplayItem: itemProfile, processedPhotoUpload: true)
                    case .failure(_):
                        self.callWSAndUpdateUser(user!, updateDisplayItem: item, processedPhotoUpload: false)
                    }
                })
            } else {
                self.callWSAndUpdateUser(user!, updateDisplayItem: item)
            }
        }
    }
    
    /// validate Email. calls isInputValid for generic input validation
    private func isEmailValid(email: String) -> Bool {
        return isInputValid(input:email) && email.isValidEmail()
    }
    
    /// validate Password. calls isInputValid for generic input validation
    private func isPasswordValid(password: String) -> Bool {
        return isInputValid(input: password)
    }
    
    /// validate name. calls isInputValid for generic input validation
    private func isNameValid(name: String) -> Bool {
        return isInputValid(input:name)
    }
    
    /// validate mobile. calls isInputValid for generic input validation
    private func isMobileValid(mobile: String) -> Bool {
        return isInputValid(input: mobile) && mobile.isValidPhone()
    }
    
    /// validate address. calls isInputValid for generic input validation
    private func isAddressValid(address: String) -> Bool {
        return isInputValid(input:address)
    }
    
    // validate inputs. Generic handle for input validations
    private func isInputValid(input: String) -> Bool {
        if input.count == 0 {
            return false
        }
        return true
    }
}
