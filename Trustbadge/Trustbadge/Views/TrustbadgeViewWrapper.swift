//
//  TrustbadgeViewWrapper.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 17/11/22.
//

import UIKit
import SwiftUI

@available(iOS 13.0.0, *)
@objc public class TrustbadgeViewWrapper : NSObject {

    @objc public static func createTrustbadgeView(tsid: String) -> UIViewController {
        return UIHostingController(rootView: TrustbadgeView(tsid: tsid))
    }
}
