//
//  ChangePasswordView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/28/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ChangePasswordView: BaseView, SettingsViewProtocol {
    @IBOutlet weak var changePasswordHeaderLabel: BetaProductHeaderLabel!
    @IBOutlet weak var changePasswordInstructionLabel: BetaProductInstructionLabel!
    @IBOutlet weak var oldPasswordView: BetaProductRoundedContainerView!
    @IBOutlet weak var oldPasswordImageView: UIImageView!
    @IBOutlet weak var oldPasswordField: BetaProductRoundedContainerField!
    @IBOutlet weak var oldPasswordButton: UIButton!
    @IBOutlet weak var newPasswordView: BetaProductRoundedContainerView!
    @IBOutlet weak var newPasswordImageView: UIImageView!
    @IBOutlet weak var newPasswordField: BetaProductRoundedContainerField!
    @IBOutlet weak var newPasswordButton: UIButton!
    @IBOutlet weak var confirmPasswordView: BetaProductRoundedContainerView!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    @IBOutlet weak var confirmPasswordField: BetaProductRoundedContainerField!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var changePasswordSaveButton: BetaProductPrimaryButton!
    @IBOutlet weak var changePasswordCancelButton: BetaProductSecondaryButton!
    @IBOutlet weak var changePasswordOrLabel: UILabel!
    var eventHandler : SettingsUpdateModuleProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI State functions
    
    func defineUIControlDefaultState() {
        changePasswordSaveButton.isHidden = true
        changePasswordCancelButton.isHidden = true
        changePasswordOrLabel.isHidden = true
        oldPasswordField.isEnabled = false
        newPasswordField.isEnabled = false
        confirmPasswordField.isEnabled = false
        oldPasswordButton.isEnabled = true
        newPasswordButton.isEnabled = true
        confirmPasswordButton.isEnabled = true
    }
    
    func defineUIControlState(shouldEnable: Bool, forField: BetaProductRoundedContainerField, withAssociatedEditButton: UIButton) {
        forField.isEnabled = shouldEnable
        withAssociatedEditButton.isEnabled = !shouldEnable
    }
    
    func defineButtonsVisibility(visibilityState: Bool) {
        changePasswordSaveButton.isHidden = visibilityState
        changePasswordCancelButton.isHidden = visibilityState
        changePasswordOrLabel.isHidden = visibilityState
    }
    
    //MARK: IBOutlet functions
    
    @IBAction func editOldPassword(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: oldPasswordField, withAssociatedEditButton: oldPasswordButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  oldPasswordField)
    }
    
    @IBAction func editNewPassword(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: newPasswordField, withAssociatedEditButton: newPasswordButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  newPasswordField)
    }
    
    @IBAction func editConfirmPassword(_ sender: Any) {
        defineUIControlState(shouldEnable: true, forField: confirmPasswordField, withAssociatedEditButton: confirmPasswordButton)
        defineButtonsVisibility(visibilityState: false)
        super.specifyFirstResponder(buttonControl:  confirmPasswordField)
    }
    
    @IBAction func savePasswordChanges(_ sender: Any) {
        var displayItems = SettingsPasswordDisplayItem()
        displayItems.passwordOld = oldPasswordField.text
        displayItems.passwordNew = newPasswordField.text
        displayItems.passwordNewConfirm = confirmPasswordField.text
        eventHandler?.saveUpdates(withItem: displayItems)
        defineUIControlDefaultState()
    }
    
    @IBAction func revertPasswordChanges(_ sender: Any) {
        defineUIControlDefaultState()
    }
    
    func displayMessage(_ message: String, isSuccessful: Bool) {
        let baseMessageView = BaseMessageView()
        baseMessageView.displayMessage(title: "", message: message, negativeButtonCaption: "Cancel", affirmativeButtonCaption: "OK", viewController: self, messageStatus: isSuccessful)
    }
}
