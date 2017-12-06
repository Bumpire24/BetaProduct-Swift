//
//  ProfileSettingsView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProfileSettingsView: BaseView {

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
    var eventHandler : SettingsUpdateModuleProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayProfileInformation()
        defineUIControlDefaultState()
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
        var displayItems = SettingsProfileDisplayItem()
        displayItems.name = fullNameField.text
        displayItems.addressShipping = billingAddressField.text
        displayItems.mobile = mobileNumberField.text
        eventHandler?.saveUpdates(withItem: displayItems)
        defineUIControlDefaultState()
    }
    
    @IBAction func revertProfileChanges(_ sender: Any) {
        defineUIControlDefaultState()
    }
    
    @IBAction func displayCameraScreen(_ sender: Any) {
        
    }
    
    @IBAction func displayPhotoLibrary(_ sender: Any) {
        
    }
    
    @IBAction func closeFloatingButtonView(_ sender: Any) {
        floatingButtonsView.isHidden = true
    }
    
    
    
    //MARK: Fetching functions
    
    func displayProfileInformation() {
        eventHandler?.updateView()
    }
    
    func populateUserProfile(displayItems: SettingsProfileDisplayItem) {
        fullNameField.text = displayItems.name
        billingAddressField.text = displayItems.addressShipping
        mobileNumberField.text = displayItems.mobile
    }

}
