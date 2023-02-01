//
//  TrustbadgeResources.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 31/01/23.
//

import Foundation

public final class TrustbadgeResources {
    public static let resourceBundle: Bundle = {
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: TrustbadgeResources.self).resourceURL,
        ]

        let bundleName = "Trustylib_Trustylib"

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }

        // Return whatever bundle this code is in as a last resort.
        return Bundle(for: TrustbadgeResources.self)
    }()
}
