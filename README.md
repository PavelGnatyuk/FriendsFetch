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
