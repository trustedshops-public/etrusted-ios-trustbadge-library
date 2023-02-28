//
//  TrustbadgeViewWrapper.swift
//  Trustylib
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
