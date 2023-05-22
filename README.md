# Trusted shops library for the iOS platform #

[![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/blob/main/LICENSE)
[![Codecov](https://codecov.io/gh/trustedshops-public/etrusted-ios-trustbadge-library/branch/develop/graph/badge.svg?token=QXzc8Z3UXF)](https://codecov.io/gh/trustedshops-public/etrusted-ios-trustbadge-library)
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/trustedshops-public/etrusted-ios-trustbadge-library/tree/develop.svg?style=shield)](https://dl.circleci.com/status-badge/redirect/gh/trustedshops-public/etrusted-ios-trustbadge-library/tree/develop)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=trustedshops-public_etrusted-ios-trustbadge-library&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=trustedshops-public_etrusted-ios-trustbadge-library)

> This project is currently work in progress and used only be a few
> customers. APIs might not be stable yet and might change without
> further notice

Trustylib library helps you integrate Trusted Shops `Trustmark`, `Shop Grade`, `Product Grade` and `Buyer Protection` UI widgets in your iOS apps. 

`Trustmark` widget shows the validity of your trust certificate issued by Trusted Shops.<br>
<img src="https://user-images.githubusercontent.com/27926337/215702112-ae9ea5c8-76f1-479c-8d2c-fc6726204f06.jpg" height="90">

In case, your trust certificate gets expired, the Trustmark widgets is presented like this,<br>
<img src="https://user-images.githubusercontent.com/27926337/215715480-a614bee6-20f8-4012-bba0-5ddbf2be46d5.png" height="90">

`Shop Grade` widget expands to show shop rating and status (Excellent, Good, Fair, etc) with a nice animated effect. The widget however shows the aggregate rating and status only, it doesn't show shop actual reviews' details like review text, review date, attachments, etc. <br>
![shop-grade](https://user-images.githubusercontent.com/27926337/233945935-5002f633-3fef-49d2-9da4-ebd5d648495b.gif)

`Buyer Protection` widget shows details about shop's buyer protection amount. This widget is available in `CocoadPod version 1.1.0+` and `Swift Package version 1.1.0+`).<br>
![buyer-protection](https://user-images.githubusercontent.com/27926337/233946329-21ef1b31-7d06-492a-b0db-ced72eeddb23.gif)

`Product Grade` widget shows product image, rating and status (Excellent, Good, Fair, etc) with an animated user interface. This widget is available in `CocoadPod version 1.2.1+` and `Swift Package version 1.2.1+`).<br>
![product-grade](https://user-images.githubusercontent.com/27926337/233946381-e363ecd9-8e8b-4cc0-beb2-0d8797113f2a.gif)

## 1. Installation ##

Trustylib can be added to your iOS projects via both [Swift Package Manager](https://www.swift.org/package-manager/) and [Cocoapods](https://cocoapods.org/).<br> 
[Example projects](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/tree/main/Example) have working integration of the Trustylib library for different iOS technology stacks.

#### *Swift Package Manager*
Trustylib library can easily be added to xcode projects via Swift Package Manager. Here is how it is done,

1. While xcode project is open, go to `File > Add Packages... >`<br>
2. Enter Trustylib library's git URL (https://github.com/trustedshops-public/etrusted-ios-trustbadge-library.git) in the search box, xcode will display the library details. Please select `Upto next major version` for the dependancy rule, xcode will automatically fill the latest Trustylib release version number i.e. `1.2.3`<br>
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

You should now have the latest version i.e. `1.2.3` of Trustylib library added to your xcode project!

## 2. Configuration ##
Trustylib calls TrustedShops backend API for loading details like trust certificate validity, grade/rating, buyer protection, etc. TrustedShops backend API has three environments `development`, `stage` and `production` and Trustylib can be configured to connect to one of these environments for loading your shop and product grade/rating details.

Trustylib looks for a runtime environment variable `Trustylib.Environment` with supported values as `development`, `stage` and `production`. If this environment variable is found with one of the supported values, library environment is set accordingly. Else, library's environment is set to `production` as default environment.

This is how, you can set this runtime environment variable via your xcode project's `scheme` settings. More details could be found [here](https://www.swiftdevjournal.com/using-environment-variables-in-swift-apps/).<br>
<img width="500" src="https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/assets/27926337/7e166e74-f875-41bd-805a-87b76f6805af">

## 3. Adding Trustylib UI widgets
Trustylib has one `TrustbadgeView` view which makes it very easy to present `Trustmark`, `Shop Grade`, `Product Grade` and `Buyer Protection` widgets. We just need to provide inputs like `TSID`, `channel id`, `product id` and `context`, based on these inputs TrustbadgeView then presents the required widgets.

This is how, the Trustmark widget is created,

```swift
TrustbadgeView(
    tsId: "X330A2E7D449E31E467D2F53A55DDD070",
    context: .trustMark
)
```

These lines of code create the Shop Grade widget,

```swift
TrustbadgeView(
    tsId: "X330A2E7D449E31E467D2F53A55DDD070",
    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
    context: .shopGrade
)
```

The Buyer Protection widget can be created with these lines of code,

```swift
TrustbadgeView(
    tsId: "X330A2E7D449E31E467D2F53A55DDD070",
    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
    context: .buyerProtection
)
```

This is how, Product Grade widget is added,

```swift
TrustbadgeView(
    tsId: "X330A2E7D449E31E467D2F53A55DDD070",
    channelId: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
    productId: "31303033",
    context: .productGrade
)
```

Product id is needed only for product grade widget and it represents product SKU. For any help realted to product id, please contact Trsuted Shop's CSM via email: members@trustedshops.comMobile.

Your `TSID` is generally shared during the onboarding process with Trusted Shops. If in case, you don't have it, please contact Trsuted Shop's CSM via email: members@trustedshops.comMobile. You may also contact Trusted Shop's mobile engineering team via email: mobileapp@trustedshops.com

`ChannelId` is available in the Trusted Shop's [Control Center](https://app.etrusted.com/) URL for a shop. For example, in this URL https://app.etrusted.com/etrusted/reviews/inbox?channels=chl-2bf4346e-9897-4e3c-8793-bdbf15c007ae, the channel id is `chl-2bf4346e-9897-4e3c-8793-bdbf15c007ae`. Here is how it looks in the Control Center URL,<br>
<img width="500" src="https://user-images.githubusercontent.com/27926337/215760110-6d00a5ec-3b0c-4458-a867-acf75d6afa8b.png">

## 4. Display Trustmark widget ##
Displaying Trustmark widget in your iOS app is pretty easy after you have added the Trustylib library to your XCode project/s. Here are the code samples for adding widgets for different iOS technology stacks,

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
                tsId: "X330A2E7D449E31E467D2F53A55DDD070",
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
            tsId: "X330A2E7D449E31E467D2F53A55DDD070",
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
            createTrustbadgeViewWithTsId:@"X330A2E7D449E31E467D2F53A55DDD070"
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

To display the Shop Grade widget, you just need to pass `shopGrade` context and a valid channel id to the TrustbadgeView in above code examples.

#### *Swift with SwiftUI*

```swift
TrustbadgeView(
   tsId: "X330A2E7D449E31E467D2F53A55DDD070",
   channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
   context: .shopGrade
)
.frame(height: 75)

```

#### *Swift with UIKit*

```swift
private lazy var trustbadgeView: UIHostingController = {
    let trustbadge = TrustbadgeView(
        tsId: "X330A2E7D449E31E467D2F53A55DDD070",
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
        createTrustbadgeViewWithTsId:@"X330A2E7D449E31E467D2F53A55DDD070"
        channelId:@"chl-b309535d-baa0-40df-a977-0b375379a3cc"
        context: TrustbadgeContextShopGrade
];
[self addChildViewController: trustbadgeViewController];
[self.view addSubview: trustbadgeViewController.view];
```

## 6. Display Buyer Protection widget ##

To display the Buyer Protection widget, you just need to pass `buyerProtection` context to the TrustbadgeView in above code examples.

#### *Swift with SwiftUI*

```swift
TrustbadgeView(
   tsId: "X330A2E7D449E31E467D2F53A55DDD070",
   channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
   context: .buyerProtection
)
.frame(height: 75)

```

#### *Swift with UIKit*

```swift
private lazy var trustbadgeView: UIHostingController = {
    let trustbadge = TrustbadgeView(
        tsId: "X330A2E7D449E31E467D2F53A55DDD070",
        channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
        context: .buyerProtection
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
        createTrustbadgeViewWithTsId:@"X330A2E7D449E31E467D2F53A55DDD070"
        channelId:@"chl-b309535d-baa0-40df-a977-0b375379a3cc"
        context: TrustbadgeContextBuyerProtection
];
[self addChildViewController: trustbadgeViewController];
[self.view addSubview: trustbadgeViewController.view];
```

## 7. Display Product Grade widget ##

This is how, Product Grade widget can be added depending on the iOS technologies stack being used for the app,

#### *Swift with SwiftUI*

```swift
TrustbadgeView(
   tsId: "X330A2E7D449E31E467D2F53A55DDD070",
   channelId: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
   productId: "31303033",
   context: .productGrade
)
.frame(height: 75)

```

#### *Swift with UIKit*

```swift
private lazy var trustbadgeView: UIHostingController = {
    let trustbadge = TrustbadgeView(
        tsId: "X330A2E7D449E31E467D2F53A55DDD070",
        channelId: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
        productId: "31303033",
        context: .productGrade
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
        createTrustbadgeViewWithTsId:@"X330A2E7D449E31E467D2F53A55DDD070"
        channelId:@"chl-c0ad29ff-a086-4191-a663-82fed64f6f65"
        productId:@"31303033"
        context: TrustbadgeContextProductGrade
];
[self addChildViewController: trustbadgeViewController];
[self.view addSubview: trustbadgeViewController.view];
```

## 8. Setting widget horizontal alignment ##
You can set the widget horizontal alignment to leading or trailing to match with your design specifications. This feature is available in `CocoadPod version 1.1.0+` and `Swift Package version 1.1.0+`).

TrustbadgeView has an optional `alignment` parameter that accepts either `.leading` or `.trailing` values. If you don't pass `alignment` parameter, the widget uses `.leading` as a default value. 

Here is how, you can configure TrustbadgeView with alignment parameter, 

```swift
TrustbadgeView(
     tsId: "X330A2E7D449E31E467D2F53A55DDD070",
     channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
     context: .shopGrade,
     alignment: .trailing
)
```

Trustbadge view considers the alignment value for expanding itself towards the correct direction to show widget details. If the alignment is set to .leading, trustbadge content expends towards right whereas for .trailing alignment, content are expended towards left.

Here is how the shop grade widget presents its contents for leading and trailing alignment,<Br>
<img src="https://user-images.githubusercontent.com/27926337/230004518-46fe40d0-7d43-4505-91f3-94c28dc01b5a.png" height="100" width="400"><br>
<img src="https://user-images.githubusercontent.com/27926337/230004550-629c4537-4532-4af1-a5e1-84132aafe092.png" height="100" width="400">

_Note_: In case you are a developer integrating Trustylib in both Android and iOS, please note that the badge alignment is slightly different in iOS and Android.

## 9. Support ##
Please [let us know](https://github.com/trustedshops-public/etrusted-ios-trustbadge-library/issues) if you
have suggestions or questions. You may also contact Trusted Shop's mobile engineering team via email: mobileapp@trustedshops.com
