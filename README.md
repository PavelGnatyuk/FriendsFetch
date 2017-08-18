# FriendsFetch
Facebook Friends Fetched. Demo application

## References
1. [Facebook. Getting started](https://developers.facebook.com/docs/ios/getting-started)
2. [Facebook. Login](https://medium.com/r/?url=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Ffacebook-login%2Fios%2Fv2.3)


### Emty project - a project template

1. Remove main storyboard from the project including the project plist.
2. Clean the AppDelegate.swift file

#### AppDelegate.swift
```code
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

```

### Add Facebook SDK
Everything should be done accordingly to the Facebook documentation. The `AppDelegate.swift` file looks so:
```code
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

```

### Add Facebook Login Button
Same about the login button:
```code
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

```
### Fetch the friends
Here is the function retrieving the taggable friends:
```code
    class func fetchFriends(cursor: String?) {
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

```

