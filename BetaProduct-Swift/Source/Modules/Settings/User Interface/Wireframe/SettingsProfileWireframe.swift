//
//  SettingsProfileWireframe.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/1/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let profileSettingsViewIdentifier = "ProfileSettingsView"

class SettingsProfileWireframe: BaseWireframe {
    var profileSettingsView : ProfileSettingsView?
    var presenter : SettingsPresenterProfile?
    
    func presentProfileSettingsViewFromViewController(_ viewController: UIViewController) {
        let newViewController = profileSettingsViewController()
        profileSettingsView = newViewController
        profileSettingsView?.eventHandler = presenter
        presenter?.profileSettingsView  = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    private func profileSettingsViewController() -> ProfileSettingsView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: profileSettingsViewIdentifier) as! ProfileSettingsView
        return viewcontroller
    }

}
