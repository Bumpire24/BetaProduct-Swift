//
//  SettingsPresenterUploadPhoto.swift
//  BetaProduct-Swift
//
//  Created by User on 11/29/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

/// presenter class for module `Settings`
class SettingsPresenterUploadPhoto: NSObject, UIImagePickerControllerDelegate, SettingsPhotoUploadModuleProtocol {
    /// variable for interactor
    var interactor: SettingsInteractorInput?
    /// variable for wireframe
    var wireframe: String?
    /// variable for view
    var view: String?
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // call wireframe to go back to profile and load image selected
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    }
    
    // MARK: SettingsPhotoUploadModuleProtocol
    /// implements protocol. see SettingsModuleProtocols.swift
    func proceedToCamera() {
        
    }
    
    func proceedToPhotoLibrary() {
        
    }
}
