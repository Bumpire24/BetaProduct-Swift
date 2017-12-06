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
class SettingsInteractor: NSObject, SettingsInteractorInput {
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
    private func constructOutput(displayItemType displayItem: SettingsDisplayItemProtocol, wasSuccessful: Bool, withMessage: String) {
        switch displayItem {
        case is SettingsPresenterEmail: self.outputEmail?.settingsUpdationComplete(wasSuccessful: wasSuccessful, withMessage: withMessage)
        case is SettingsPresenterPassword: self.outputPassword?.settingsUpdationComplete(wasSuccessful: wasSuccessful, withMessage: withMessage)
        default: break
        }
    }
    
    // calls Webservice and updates local data
    private func callWSAndUpdateUser(_ user: User, updateDisplayItem item: SettingsDisplayItemProtocol) {
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
                        self.constructOutput(displayItemType: item, wasSuccessful: true, withMessage: "Update was successful!")
                    case .failure(let error):
                        self.constructOutput(displayItemType: item, wasSuccessful: false, withMessage: (error?.localizedDescription)!)
                    }
                })
            case .failure(let error):
                self.constructOutput(displayItemType: item, wasSuccessful: false, withMessage: (error?.localizedDescription)!)
            }
        })
    }
    
    // calls Webservice and updates local data
//    private func callWSAndUpdateUser(updateDisplayItem item: SettingsProfileDisplayItem, processedPhotoUpload photoUploadWasGood: Bool?) {
//        var user = session?.getUserSessionAsUser()
//        user?.fullname = item.name!
//        user?.mobile = item.mobile!
//        user?.addressShipping = item.addressShipping!
//
//        var photoGood = false
//        var message = ""
//        // Check if there was a photo upload
//        if let wasSuccessful = photoUploadWasGood {
//            photoGood = wasSuccessful || photoGood
//            if wasSuccessful {
//                message = "Photo Upload was successful!"
//            } else {
//                message = "Photo Upload failed"
//            }
//        }
//
//        self.webservice?.PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: user!.allProperties(), block: { response in
//            switch response {
//            case .success(let value):
//                self.manager?.updateUser(user: user!, withCompletionBlock: { response in
//                    switch response {
//                    case .success(_):
//                        // Set new Session
//                        if let list = value, let targetUser = list.first, let converted = targetUser as? [String:Any] {
//                            let updatedUser = User.init(dictionary: converted)
//                            self.session?.setUserSessionByUser(updatedUser)
//                        } else {
//                            // failed to convert User
//                            DDLogError("Error  description : User conversion failure. reason : Failed to convert Dictionary to Session. suggestion : Debug function \(#function)")
//                        }
//                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || true,
//                                                                     withMessage: "Profile Update was successful! " + message,
//                                                                     withNewDisplayItem: item)
//                    case .failure(let error):
//                        self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || false,
//                                                                     withMessage: message + " " + (error?.localizedDescription)!,
//                                                                     withNewDisplayItem: item)
//                    }
//                })
//            case .failure(let error):
//                if photoUploadWasGood != nil {
//                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: photoGood || false,
//                                                                 withMessage: message + " " + (error?.localizedDescription)!,
//                                                                 withNewDisplayItem: item)
//                } else {
//                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: false,
//                                                                 withMessage: (error?.localizedDescription)!,
//                                                                 withNewDisplayItem: item)
//                }
//            }
//        })
//    }
    
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
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Old Email Address Incorrect!")
            return
        }
        
        guard let emailNew = item.emailAddNew?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: emailNew) else {
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Email Address Incorrect!")
            return
        }
        
        guard let emailNewC = item.emailAddNewConfirm?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: emailNewC) else {
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Confirm New Email Address Incorrect!")
            return
        }
        
        var user = session?.getUserSessionAsUser()
        if emailOld != user?.email {
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Email does not match your Current Email")
            return
        }
        
        if emailNew != emailNewC {
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Email and Confirm New Email does not match")
            return
        }
        
        if emailOld == emailNew {
            self.outputEmail?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Email and New Email are the same")
            return
        }
        
        user?.email = item.emailAddNew!
        self.callWSAndUpdateUser(user!, updateDisplayItem: item)
    }
    
    /// validates Password Update
    private func validateAndUpdatePassword(_ item: SettingsPasswordDisplayItem) {
        guard let passOld = item.passwordOld?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passOld) else {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Old Password Incorrect!")
            return
        }
        
        guard let passNew = item.passwordNew?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passNew) else {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Password Incorrect!")
            return
        }
        
        guard let passNewC = item.passwordNewConfirm?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: passNewC) else {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Confirm New Password Incorrect!")
            return
        }
        
        var user = session?.getUserSessionAsUser()
        if passOld != user?.password {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Password does not match your Current Password")
            return
        }
        
        if passNew != passNewC {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "New Password and Confirm New Password does not match")
            return
        }
        
        if passOld == passNew {
            self.outputPassword?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Your Old Password and New Password are the same")
        }
        
        user?.password = item.passwordNew!
        self.callWSAndUpdateUser(user!, updateDisplayItem: item)
    }
    
    /// validates Profile Update
    private func validateAndUpdateProfile(_ item: SettingsProfileDisplayItem) {
        // check if items are not equal
        let itemFromSession = makeSettingsProfileDisplayItemFromSession()
        if item == itemFromSession {
            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "No changes found for Profile!", withNewDisplayItem: item)
        } else {
            // check if values are nil, empty strings or valid
            guard let name = item.name?.trimmingCharacters(in: .whitespacesAndNewlines), isNameValid(name: name) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Name Incorrect!", withNewDisplayItem: item)
                return
            }
            
            guard let mobile = item.mobile?.trimmingCharacters(in: .whitespacesAndNewlines), isMobileValid(mobile: mobile) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Mobile Incorrect!", withNewDisplayItem: item)
                return
            }
            
            guard let address = item.addressShipping?.trimmingCharacters(in: .whitespacesAndNewlines), isAddressValid(address: address) else {
                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Address Incorrect!", withNewDisplayItem: item)
                return
            }
            
            // start transactions here
            let downloadGroup = DispatchGroup()
            let processPhoto = item.profileImage.image != nil
            let processProfile = item.name != itemFromSession.name || item.addressShipping != itemFromSession.addressShipping || item.mobile != itemFromSession.mobile
            var processPhotoResult: String?
//            var processProfileResult: [String: Any]?
            var processPhotoMessage = ""
            var processProfileMessage = ""
            var processPhotoGood = false
            var processProfileGood = false
            
            var user = session?.getUserSessionAsUser()
            user?.fullname = item.name!
            user?.mobile = item.mobile!
            user?.addressShipping = item.addressShipping!
            
            if processPhoto {
                downloadGroup.enter()
                webservice?.UploadImage(asData: UIImagePNGRepresentation(item.profileImage.image!)!, toURL: BetaProduct.kBPWSPostUserImage, WithCompletionBlock: { response in
                    switch response {
                    case .success(_):
                        // tempo image
                        processPhotoResult = "http://placehold.it/600/92c952"
                        processPhotoMessage = "Photo Upload successful!"
                        processPhotoGood = true
                    case .failure(let error):
                        processPhotoMessage = (error?.localizedDescription)!
                    }
                    downloadGroup.leave()
                })
            }
            
            if processProfile {
                downloadGroup.enter()
                self.webservice?.PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: user!.allProperties(), block: { response in
                    switch response {
                    case .success(_):
//                        processProfileResult = value?.first as? [String: Any]
                        processProfileMessage = "Profile Update successful!"
                        processProfileGood = true
                    case .failure(let error):
                        processProfileMessage = (error?.localizedDescription)!
                    }
                    downloadGroup.leave()
                })
            }
            
            // finished all queues
            downloadGroup.notify(queue: .main, execute:{
                if processPhotoGood || processProfileGood {
                    // if either transact is good conduct updation in core and sesison
                    var itemUpdated = item
                    if processPhotoGood {
                        itemUpdated.profileImage.url = processPhotoResult
                        user?.profileImageURL = processPhotoResult!
                    }
                    // call manager for saving
                    self.manager?.updateUser(user: user!, withCompletionBlock: { response in
                        switch response {
                        case .success(_):
                            // update session
                            self.session?.setUserSessionByUser(user!)
                            self.outputProfile?.settingsUpdationComplete(wasSuccessful: true, withMessage: processProfileMessage + " " + processPhotoMessage, withNewDisplayItem: itemUpdated)
//                            if let dataDict = processProfileResult {
//                                let updatedUser = User.init(dictionary: dataDict)
//                                self.session?.setUserSessionByUser(updatedUser)
//                                self.outputProfile?.settingsUpdationComplete(wasSuccessful: true, withMessage: processProfileMessage + " " + processPhotoMessage, withNewDisplayItem: itemUpdated)
//                            } else {
//                                // failed to convert User
//                                DDLogError("Error  description : User conversion failure. reason : Failed to convert Dictionary to Session. suggestion : Debug function \(#function)")
//                                self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Profile Update Failed", withNewDisplayItem: item)
//                            }
                        case .failure(_):
                            self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Profile Update Failed", withNewDisplayItem: item)
                        }
                    })
                } else {
                    self.outputProfile?.settingsUpdationComplete(wasSuccessful: false, withMessage: "Profile Update Failed", withNewDisplayItem: item)
                }
            })
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
