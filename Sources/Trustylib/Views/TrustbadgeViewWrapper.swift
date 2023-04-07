//
//  Copyright (C) 2023 Trusted Shops AG
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Prem Pratap Singh on 17/11/22.
//

import UIKit
import SwiftUI

/**
 TrustbadgeViewWrapper is a wrapper view for adding TrustbadgeView to UIKit based
 Objective-C applications.
 
 Please see https://github.com/trustedshops-public/etrusted-ios-trustbadge-library Readme for
 more details
 */
@available(iOS 13.0.0, *)
@objc public class TrustbadgeViewWrapper : NSObject {

    /**
     Creates wrapper view for TrustbadgeView and return the same
     */
    @objc public static func createTrustbadgeView(
        tsid: String,
        channelId: String,
        context: TrustbadgeContext) -> UIViewController {
        return UIHostingController(
            rootView: TrustbadgeView(tsid: tsid, channelId: channelId, context: context)
        )
    }
}
