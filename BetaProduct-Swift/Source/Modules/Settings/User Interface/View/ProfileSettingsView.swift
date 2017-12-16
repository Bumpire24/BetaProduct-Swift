//
//  ProfileSettingsView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProfileSettingsView: BaseView, SettingsProfileViewProtocol {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var fullNameView: BetaProductRoundedContainerView!
    @IBOutlet weak var fullNameImage: UIImageView!
    @IBOutlet weak var fullNameField: BetaProductRoundedContainerField!
    @IBOutlet weak var fullNameButton: UIButton!
    @IBOutlet weak var billingAddressView: BetaProductRoundedContainerView!
    @IBOutlet weak var billingAddressImage: UIImageView!
    @IBOutlet weak var billingAddressField: BetaProductRoundedContainerField!
    @IBOutlet weak var billingAddressButton: UIButton!
    @IBOutlet weak var mobileNumberView: BetaProductRoundedContainerView!
    @IBOutlet weak var mobileNumberImage: UIImageView!
    @IBOutlet weak var mobileNumberField: BetaProductRoundedContainerField!
    @IBOutlet weak var mobileNumberButton: UIButton!
    @IBOutlet weak var saveProfileButton: BetaProductPrimaryButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var cancelProfileButton: BetaProductSecondaryButton!
    @IBOutlet weak var profileVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var floatingButtonsView: UIView!
    var eventHandler : SettingsProfileModuleProtocol?
    var displayItem = SettingsProfileDisplayItem()
    var newDisplayImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayProfileInformation()
        defineUIControlDefaultState()
        populateButtons()
        enableTapGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI State functions
    
    func defineUIControlDefaultState() {
        saveProfileButton.isHidden = true
        cancelProfileButton.isHidden = true
        orLabel.isHidden = true
        fullNameField.isEnabled = false
        billingAddressField.isEnabled = false
        mobileNumberField.isEnabled = false
        profileButton.isEnabled = true
        fullNameButton.isEnabled = true
        billingAddressButton.isEnabled = true
        mobileNumberButton.isEnabled = true
    }
    
    func defineUIControlState(shouldEnable: Bool, forField: BetaProductRoundedContainerField, withAssociatedEditButton: UIButton) {
        forField.isEnabled = shouldEnable
        withAssociatedEditButton.isEnabled = !shouldEnable
    }
    
    func defineButtonsVisibility(visibilityState: Bool) {
        saveProfileButton.isHidden = visibilityState
        cancelProfileButton.isHidden = visibilityState
        orLabel.isHidden = visibilityState
    }
    
    //MARK: IBOutlet functions
    @IBAction func editProfileImage(_ sender: Any) {
        floatingButtonsView.isHidden = false
    }
    
    @IBAction func editFullName(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: fullNameField, withAssociatedEditButton: fullNameButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  fullNameField)
    }
    
    @IBAction func editBillingAddress(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: billingAddressField, withAssociatedEditButton: billingAddressButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  billingAddressField)
    }
    
    @IBAction func editMobileNumber(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: mobileNumberField, withAssociatedEditButton: mobileNumberButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  mobileNumberField)
    }
    
    @IBAction func saveProfileChanges(_ sender: Any) {
        displayItem.firstName = fullNameField.text
        displayItem.addressShipping = billingAddressField.text
        displayItem.mobile = mobileNumberField.text
        if let imageToUpdate = newDisplayImage {
            displayItem.profileImage.image = imageToUpdate
        }
        eventHandler?.saveUpdates(withItem: displayItem)
        defineUIControlDefaultState()
    }
    
    @IBAction func revertProfileChanges(_ sender: Any) {
        defineUIControlDefaultState()
    }
    
    @IBAction func displayCameraScreen(_ sender: Any) {
        eventHandler?.proceedToCamera()
    }
    
    @IBAction func displayPhotoLibrary(_ sender: Any) {
        eventHandler?.proceedToPhotoLibrary()
    }
    
    @IBAction func closeFloatingButtonView(_ sender: Any) {
        floatingButtonsView.isHidden = true
    }
    
    //MARK: Fetching functions
    
    func displayProfileInformation() {
        eventHandler?.updateView()
    }
    
    func populateUserProfile(displayItems: SettingsProfileDisplayItem) {
        displayItem = displayItems
        fullNameField.text = displayItems.firstName
        billingAddressField.text = displayItems.addressShipping
        mobileNumberField.text = displayItems.mobile
    }
    
    func populateButtons() {
        self.saveProfileButton.setTitle("Save", for: .normal)
        self.saveProfileButton.titleLabel?.textColor = BetaProductStyle.iDoohButtonFontColor
        self.cancelProfileButton.setTitle("Cancel", for: .normal)
    }
    
    func displayMessage(_ message : String, isSuccessful : Bool) {
        let baseMessageView = BaseMessageView()
        baseMessageView.displayMessage(title: "", message: message, negativeButtonCaption: "Cancel", affirmativeButtonCaption: "OK", viewController: self, messageStatus: isSuccessful)
    }

    func updateViewWithNewProfileImage(image: UIImage) {
        profileImage.image = image
        newDisplayImage = image
    }
}
