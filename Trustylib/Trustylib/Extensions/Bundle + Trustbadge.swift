//
//  Bundle + Trustbadge.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 30/01/23.
//

import Foundation

extension Bundle {

    /// Returns reference of the trustbadge bundle id
    static var trustbadgeBundle: Bundle? {
        return Bundle(identifier: "com.etrusted.ios.trustylib")
    }
}
