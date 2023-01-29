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
        return Color("TsGray100", bundle: Bundle.init(path: "com.etrusted.ios.trustylib"))
    }

    /// Trustedshops pineapple 500 color
    static var tsPineapple500: Color {
        return Color("TsPineapple500", bundle: Bundle.init(path: "com.etrusted.ios.trustylib"))
    }
}
