//
//  Color + TsColors.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import Foundation
import SwiftUI

/**
 This extension defines custom Trustedshops colors
 */
extension Color {

    /// Trustedshops gray 100 color
    static var tsGray100: Color {
        let uiColor = UIColor(
            named: "TsGray100",
            in: Bundle(identifier:"com.etrusted.ios.trustylib"),
            compatibleWith: nil)
        return Color(uiColor: uiColor ?? .gray)
    }

    /// Trustedshops pineapple 500 color
    static var tsPineapple500: Color {
        let uiColor = UIColor(
            named: "TsPineapple500",
            in: Bundle(identifier:"com.etrusted.ios.trustylib"),
            compatibleWith: nil)
        return Color(uiColor: uiColor ?? .yellow)
    }
}
