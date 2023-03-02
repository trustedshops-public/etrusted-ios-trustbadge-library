//
//  Trustbadge.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 Trustbadge is the main interface for Trustylib library and has a static method named `configure`
 that needs to be called before integrating the library widgets.

 The configure method looks for a required trustylib configuration file named `TrustbadgeConfiguration.plist`
 with important details like `client id`, `client secret`, etc which are required to load shop grades, product grades, etc
 */
public class Trustbadge {


    // MARK: Public methods

    /**
     Calls TrustbadgeConfigurationService to load the required libary configuration details.
     */
    public static func configure() {
        do {
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: Bundle.main)
        } catch {
            TSConsoleLogger.log(
                messege: "Error loading trustbadge configuration. Please check if the application has valid TrustbadgeConfiguration.plist file with required key value pairs. Trustylib library's Git project readme has more details about the required configuration file.",
                severity: .error
            )
        }
    }
}
