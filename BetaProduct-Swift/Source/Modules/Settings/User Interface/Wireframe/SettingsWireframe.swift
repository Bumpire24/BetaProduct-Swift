//
//  SettingsWireframe.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let settingsViewIdentifier = "SettingsView"

class SettingsWireframe: BaseWireframe {
    var settingsView : SettingsView?
    var rootWireFrame : RootWireframe?
    //var settingsPresenter : SettingsPresenter?
    var homeWireFrame : HomeWireframe?
    
    func presentSettingsViewFromViewController(_ viewController: UIViewController) {
        let newViewController = settingsViewController()
        settingsView = newViewController
        //settingsView?.eventHandler = settingsPresenter
        //settingsPresenter?.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func settingsViewController() -> SettingsView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: settingsViewIdentifier) as! SettingsView
        return viewcontroller
    }
}
