//
//  TrustbadgeViewWrapper.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 17/11/22.
//

import UIKit
import SwiftUI

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
