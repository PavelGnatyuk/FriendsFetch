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
        
        let buttonLogin: FBSDKLoginButton = FBSDKLoginButton()
        buttonLogin.readPermissions = ["public_profile", "email", "user_friends"]
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonLogin)
        buttonLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonLogin.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        let buttonFriends = UIButton()
        buttonFriends.translatesAutoresizingMaskIntoConstraints = false
        buttonFriends.setTitle("Fetch friends", for: .normal)
        buttonFriends.setTitleColor(.blue, for: .normal)
        buttonFriends.addTarget(self, action: #selector(clickOnFriends), for: .touchUpInside)
        
        view.addSubview(buttonFriends)
        buttonFriends.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonFriends.topAnchor.constraint(lessThanOrEqualTo: buttonLogin.bottomAnchor, constant: 20).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func clickOnFriends() {
        self.fetchFriends(cursor: nil)
    }
    
}

extension ViewController {
    func fetchFriends(cursor: String?) {
        if FBSDKAccessToken.current() != nil {
            
            var params = [String: String]()
            params["fields"] = "id,name,picture,first_name,last_name,middle_name"
            if let after = cursor {
                params["after"] = after
            }
            let request: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params, httpMethod: "GET")
            
            request.start { (_, result, error) in
                
                if let error = error {
                    print("\(String(describing: error))")
                }
                else {
                    if let data = result as? [String: Any] {
                        if let friends = data["data"] as? [Any] {
                            for friend in friends {
                                if let info = friend as? [String: Any],
                                    let id = info["id"],
                                    let name = info["name"],
                                    let picture = info["picture"] as? [String: Any],
                                    let pictureData = picture["data"] as? [String: Any],
                                    let url = pictureData["url"] {
                                    
                                    print("id: \(id)\nname:\(name)\nurl:\(url)")
                                }
                            }
                        }
                        
                        if let paging = data["paging"] as? [String: Any],
                            let cursors = paging["cursors"] as? [String: Any],
                            let after = cursors["after"] as? String {
                            
                            self.fetchFriends(cursor: after)
                        }
                    }
                }
            }
        }
    }
}


