//
//  ViewController.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 21/2/25.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    @IBAction func onLoginButtonClicked(_ sender: Any) {
        StoryboardNavigator.navigate(to: LoginViewController.self,
                storyboard: "LoginStoryboard",
                withIdentifier: "LoginViewController",
                from: self)
    }
    
    @IBAction func onRegistrationButtonClicked(_ sender: Any) {
        StoryboardNavigator.navigate(to: RegistrationViewController.self,
                storyboard: "RegistrationStoryboard",
                withIdentifier: "RegistrationViewController",
                from: self)
    }
}


