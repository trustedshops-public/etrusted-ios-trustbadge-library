# Trusted shops library for the iOS platform #

[![Platform](https://img.shields.io/cocoapods/p/Trustylib.svg?style=flat)](http://cocoapods.org/pods/Trustylib)
[![Version](https://img.shields.io/cocoapods/v/Trustylib.svg?style=flat)](http://cocoapods.org/pods/Trustylib)
[![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/blob/main/LICENSE)
[![codecov](https://codecov.io/gh/trustedshops-public/etrusted-ios-trustbadge-library/branch/main/graph/badge.svg?token=QXzc8Z3UXF)](https://codecov.io/gh/trustedshops-public/etrusted-ios-trustbadge-library)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=trustedshops-public_etrusted-ios-trustbadge-library&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=trustedshops-public_etrusted-ios-trustbadge-library)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=trustedshops-public_etrusted-ios-trustbadge-library&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=trustedshops-public_etrusted-ios-trustbadge-library)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=trustedshops-public_etrusted-ios-trustbadge-library&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=trustedshops-public_etrusted-ios-trustbadge-library)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=trustedshops-public_etrusted-ios-trustbadge-library&metric=bugs)](https://sonarcloud.io/summary/new_code?id=trustedshops-public_etrusted-ios-trustbadge-library)


> This project is currently work in progress and used only be a few
> customers. APIs might not be stable yet and might change without
> further notice

Trustylib library helps you integrate Trusted Shops `Trustmark` and `Shop Grade` UI widgets in your iOS apps with an easy configuration and small piece of code. 

Trustmark widget shows the validity of your trust certificate issues by Trusted Shop.<br>
<img src="https://user-images.githubusercontent.com/27926337/215702112-ae9ea5c8-76f1-479c-8d2c-fc6726204f06.jpg" height="90">

In case, your trust certificate gets expired, the Trustmark widgets is presented like this,<br>
<img src="https://user-images.githubusercontent.com/27926337/215715480-a614bee6-20f8-4012-bba0-5ddbf2be46d5.png" height="90">

Shop Grade widget expands to show shop rating and status with a nice animation effect. The widget however shows the aggregate rating and status only, it doesn't show shop reviews' details. <br>
<img src="https://user-images.githubusercontent.com/27926337/215702099-a4a99457-23e6-41b9-9811-f91282a1f4fc.jpg" height="100">

## 1. Installation ##

Trustylib can be added to your iOS projects via both [Swift Package Manager](https://www.swift.org/package-manager/) and [Cocoapods](https://cocoapods.org/).<br> 
[Example projects](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/tree/main/Example) have working integration of the Trustylib library for different iOS technology stacks.

#### *Swift Package Manager*
Trustylib library can easily be added to xcode projects via Swift Package Manager. Here is how it is done,

1. While xcode project is open, go to `File > Add Packages... >`<br>
2. Enter Trustylib library's git URL (https://github.com/trustedshops-public/etrusted-ios-trustbadge-library.git) in the search box, xcode will display the library details. Please select `Upto next major version` for the dependancy rule, xcode will automatically fill the latest Trustylib release version number.<br>
<img width="500" src="https://user-images.githubusercontent.com/27926337/215734320-5441934d-7aa3-4d38-9720-812a1a656e11.png"><br> 
3. Click on `Add package` button. Xcode will clone the Trustylib git repository and attach to the xcode project, it should look like this,<br>
<img width="250" src="https://user-images.githubusercontent.com/27926337/215734354-9c807b84-aa46-4ad3-937a-31f33c21d8b9.png"><br>
4. Great! The library is now added to the xcode project and is all good for use.

#### *Cocoapods*
You need to install Cocoapods first, if not already installed. Cocoapods [usase guides](https://guides.cocoapods.org/using/using-cocoapods.html) have details about installing and using it. 

After installation, you need to include `Trustylib` library as a pod in the podfile,

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target 'MyApp' do
  pod 'Trustylib'
end
```

And then run pod install command in the terminal,

```
pod install
```

You should now have the latest version of Trustylib library added to your xcode project!

## 2. Configuration ##
Once Trustylib library is added to your xcode project, one configuration file named `TrustbadgeConfiguration.plist` needs to be added to the project. 
This configuration file has details about your `client id` and `secret` which the library needs for authentication purpose. This is how the configuration file looks like, 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ClientId</key>
	<string><YOUR_CLIENT_ID></string>
	<key>ClientSecret</key>
	<string><YOUR_CLIENT_SECRET></string>
</dict>
</plist>
```

Please contact us at mobileapp@trustedshops.com for a demo shop's client id and secret values which you can use to configure and run TrustyLib [example projects](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/tree/main/Example).

This Trusted Shop's [documentation](https://developers.etrusted.com/solutions/api_credentials.html) has details about how to create your own client id and secret. For any help, please contact CSM via members@trustedshops.com

After adding this required configuration file, you need to call `Trustbadge.configure()` method prefferable in the AppDelegate (UIKit) or the App struct (SwiftUI).

```swift
import Trustylib
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Trustbadge.configure()
        return true
    }
}
```

```swift
import Trustylib
import SwiftUI

@main
struct LibTest24App: App {
    init() {
        Trustbadge.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## 3. Adding Trustylib UI widgets
Trustylib has one `TrustbadgeView` view which makes it very easy to present both `Trustmark` and `Shop Grade` widgets. We just need to provide the `channel id`, `TSID` and `context`, based on these inputs TrustbadgeView presents the required widgets.

This is how, the Trustmark widget is created,

```swift
TrustbadgeView(
    tsid: "X330A2E7D449E31E467D2F53A55DDD070",
    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
    context: .trustMark
)
```

These lines of code create the Shop Grade widget,

```swift
TrustbadgeView(
    tsid: "X330A2E7D449E31E467D2F53A55DDD070",
    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
    context: .shopGrade
)
```

Your `TSID` is generally shared during the onboarding process with Trusted Shops. If in case, you don't have it, please contact Trsuted Shop's CSM via email: members@trustedshops.comMobile. You may also contact Trusted Shop's mobile engineering team via email: mobileapp@trustedshops.com

`ChannelId` is available in the Trusted Shop's [Control Center](https://app.etrusted.com/) URL for a shop. For example, in this URL https://app.etrusted.com/etrusted/reviews/inbox?channels=chl-2bf4346e-9897-4e3c-8793-bdbf15c007ae, the channel id is `chl-2bf4346e-9897-4e3c-8793-bdbf15c007ae`. Here is how it looks in the Control Center URL,<br>
<img width="500" src="https://user-images.githubusercontent.com/27926337/215760110-6d00a5ec-3b0c-4458-a867-acf75d6afa8b.png">

## 4. Display Trustmark widget ##
Displaying Trustmark widget to your iOS app is pretty easy after you have installed the Trustylib library and configured it with the required `TrustbadgeConfiguration.plist` configuration. Here are the code samples for different iOS tech stacks,

#### *Swift with SwiftUI*
Trustylib widgets are created using SwiftUI, hence its pretty straight forward to use them in SwiftUI projects.

```swift
import Trustylib
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            TrustbadgeView(
                tsid: "X330A2E7D449E31E467D2F53A55DDD070",
                channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
                context: .trustMark
            )
            .frame(height: 75)
        }
        .padding()
    }
}
```

#### *Swift with UIKit*
Trustylib widgets are created using SwiftUI framework, therefore we need to wrap the Trustbadge widget with [UIHostingController](https://developer.apple.com/documentation/swiftui/uihostingcontroller) so that the widget could be added to the views created with UIKit framework. Here is how it is done,

```swift
import UIKit
import SwiftUI
import Trustylib

class RootViewController: UIViewController {
    private lazy var trustbadgeView: UIHostingController = {
        let trustbadge = TrustbadgeView(
            tsid: "X330A2E7D449E31E467D2F53A55DDD070",
            channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
            context: .trustMark
        )
        return UIHostingController(rootView: trustbadge)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTrustbadgeView()
    }

    private func addTrustbadgeView() {
        self.addChild(self.trustbadgeView)
        self.view.addSubview(self.trustbadgeView.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        self.trustbadgeView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.trustbadgeView.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.trustbadgeView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.trustbadgeView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.trustbadgeView.view.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
```

#### *Objective-C with UIKit*
Trustylib library has [TrustbadgeViewWrapper](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/blob/main/Sources/Trustylib/Views/TrustbadgeViewWrapper.swift) for adding Trustbadge views to Objective-C code. Below code shows, how it is done,

```objective-c
#import "RootViewControllerObjectiveC.h"
#import <Trustylib/Trustylib-Swift.h>

@interface RootViewControllerObjectiveC ()
@end

@implementation RootViewControllerObjectiveC{
    UILabel *label;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIViewController *trustbadgeViewController = [
        TrustbadgeViewWrapper
            createTrustbadgeViewWithTsid:@"X330A2E7D449E31E467D2F53A55DDD070"
            channelId:@"chl-b309535d-baa0-40df-a977-0b375379a3cc"
            context: TrustbadgeContextTrustMark
    ];
    [self addChildViewController: trustbadgeViewController];
    [self.view addSubview: trustbadgeViewController.view];
    trustbadgeViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [trustbadgeViewController.view.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor].active = YES;
    [trustbadgeViewController.view.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 16].active = YES;
    [trustbadgeViewController.view.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: -16].active = YES;
    [trustbadgeViewController.view.heightAnchor constraintEqualToConstant: 75].active = YES;
}

@end
```

## 5. Display Shop Grade widget ##

To display the Shop Grade widget, you just need to pass `shopGrade` context to the TrustbadgeView in above code examples.

#### *Swift with SwiftUI*

```swift
TrustbadgeView(
   tsid: "X330A2E7D449E31E467D2F53A55DDD070",
   channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
   context: .shopGrade
)
.frame(height: 75)

```

#### *Swift with UIKit*

```swift
private lazy var trustbadgeView: UIHostingController = {
    let trustbadge = TrustbadgeView(
        tsid: "X330A2E7D449E31E467D2F53A55DDD070",
        channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
        context: .shopGrade
    )
    return UIHostingController(rootView: trustbadge)
}()
    
private func addTrustbadgeView() {
    self.addChild(self.trustbadgeView)
    self.view.addSubview(self.trustbadgeView.view)

    /// Setup the constraints to update the SwiftUI view boundaries.
    self.trustbadgeView.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        self.trustbadgeView.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.trustbadgeView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
        self.trustbadgeView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        self.trustbadgeView.view.heightAnchor.constraint(equalToConstant: 75)
    ])
}
```

#### *Objective-C with UIKit*

```objective-c
UIViewController *trustbadgeViewController = [
    TrustbadgeViewWrapper
        createTrustbadgeViewWithTsid:@"X330A2E7D449E31E467D2F53A55DDD070"
        channelId:@"chl-b309535d-baa0-40df-a977-0b375379a3cc"
        context: TrustbadgeContextShopGrade
];
[self addChildViewController: trustbadgeViewController];
[self.view addSubview: trustbadgeViewController.view];
```

## 6. Support ##
Please [let us know](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/issues) if you
have suggestions or questions. You may also contact Trusted Shop's mobile engineering team via email: mobileapp@trustedshops.com





