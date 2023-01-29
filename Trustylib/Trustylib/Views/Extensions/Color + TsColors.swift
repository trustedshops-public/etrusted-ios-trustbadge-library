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
public extension Color {

    /// Trustedshops gray 100 color
    static var tsGray100: Color {
        return Color("TsGray100", bundle: Bundle(identifier: "com.etrusted.ios.trustylib"))
        //return Color("TsGray100", bundle: Bundle.init(path: "com.etrusted.ios.trustylib"))
        //return Color("TsGray100", in: .module, compatibleWith: nil)
        //return Color("TsGray100")
    }

    /// Trustedshops pineapple 500 color
    static var tsPineapple500: Color {
        return Color("TsPineapple500", bundle: Bundle(identifier: "com.etrusted.ios.trustylib"))
        //return Color("TsPineapple500", bundle: Bundle.init(path: "com.etrusted.ios.trustylib"))
        //return Color("TsPineapple500")
    }
}
