//
//  ChangeEmailView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ChangeEmailView: BaseView {

    @IBOutlet weak var changeEmailHeaderLabel: BetaProductHeaderLabel!
    @IBOutlet weak var changeEmailInstructionLabel: BetaProductInstructionLabel!
    @IBOutlet weak var oldEmailAddressView: BetaProductRoundedContainerView!
    @IBOutlet weak var oldEmailImageView: UIImageView!
    @IBOutlet weak var oldEmailAddressField: BetaProductRoundedContainerField!
    @IBOutlet weak var oldEmailAddressButton: UIButton!
    @IBOutlet weak var newEmailAddressView: BetaProductRoundedContainerView!
    @IBOutlet weak var newEmailImageView: UIImageView!
    @IBOutlet weak var newEmailAddressField: BetaProductRoundedContainerField!
    @IBOutlet weak var newEmailAddressButton: UIButton!
    @IBOutlet weak var confirmEmailAddressView: BetaProductRoundedContainerView!
    @IBOutlet weak var confirmEmailImageView: UIImageView!
    @IBOutlet weak var confirmEmailAddressField: BetaProductRoundedContainerField!
    @IBOutlet weak var confirmEmailAddressButton: UIButton!
    @IBOutlet weak var changeEmailAddressSaveButton: BetaProductPrimaryButton!
    @IBOutlet weak var changeEmailAddressCancelButton: BetaProductSecondaryButton!
    @IBOutlet weak var changeEmailOrLabel: UILabel!
    var eventHandler : SettingsUpdateModuleProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defineUIControlDefaultState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI State functions
    
    func defineUIControlDefaultState() {
        changeEmailAddressSaveButton.isHidden = true
        changeEmailAddressCancelButton.isHidden = true
        changeEmailOrLabel.isHidden = true
        oldEmailAddressField.isEnabled = false
        newEmailAddressField.isEnabled = false
        confirmEmailAddressField.isEnabled = false
        oldEmailAddressButton.isEnabled = true
        newEmailAddressButton.isEnabled = true
        confirmEmailAddressButton.isEnabled = true
    }
    
    func defineUIControlState(shouldEnable: Bool, forField: BetaProductRoundedContainerField, withAssociatedEditButton: UIButton) {
        forField.isEnabled = shouldEnable
        withAssociatedEditButton.isEnabled = !shouldEnable
    }
    
    func defineButtonsVisibility(visibilityState: Bool) {
        changeEmailAddressSaveButton.isHidden = visibilityState
        changeEmailAddressCancelButton.isHidden = visibilityState
        changeEmailOrLabel.isHidden = visibilityState
    }
    
    func specifyFirstResponder(buttonControl : BetaProductRoundedContainerField) {
        buttonControl.becomeFirstResponder()
    }
    
    //MARK: IBOutlet functions
    
    @IBAction func editOldEmail(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: oldEmailAddressField, withAssociatedEditButton: oldEmailAddressButton)
        defineButtonsVisibility(visibilityState: false)
        specifyFirstResponder(buttonControl:  oldEmailAddressField)
    }
    
    @IBAction func editNewEmail(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: newEmailAddressField, withAssociatedEditButton: newEmailAddressButton)
        defineButtonsVisibility(visibilityState: false)
        specifyFirstResponder(buttonControl:  newEmailAddressField)
    }
    
    @IBAction func editConfirmEmail(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: confirmEmailAddressField, withAssociatedEditButton: confirmEmailAddressButton)
        defineButtonsVisibility(visibilityState: false)
        specifyFirstResponder(buttonControl:  confirmEmailAddressField)
    }
    
    @IBAction func saveEmailChanges(_ sender: Any) {
        var displayItems = SettingsEmailDisplayItem()
        displayItems.emailAddOld = oldEmailAddressField.text
        displayItems.emailAddNew = newEmailAddressField.text
        displayItems.emailAddNewConfirm = confirmEmailAddressField.text
        eventHandler?.saveUpdates(withItem: displayItems)
        defineUIControlDefaultState()
    }
    
    @IBAction func revertProfileChanges(_ sender: Any) {
        defineUIControlDefaultState()
    }
}
