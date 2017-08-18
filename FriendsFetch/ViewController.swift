//
//  ViewController.swift
//  FriendsFetch
//
//  Created by Pavel Gnatyuk on 18/08/2017.
//  Copyright © 2017 Pavel Gnatyuk. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button: FBSDKLoginButton = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

