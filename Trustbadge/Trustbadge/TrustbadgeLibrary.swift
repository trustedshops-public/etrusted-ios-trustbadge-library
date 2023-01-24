//
//  TrustbadgeLibrary.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustbadgeLibrary is the main interface for Trustbadge library and has a static method named `configure`
 that needs to be called before integrating the library widgets.

 The configure method looks for a required trustbadge configuration file named `TrustbadgeConfiguration.plist`
 with important details like `client id`, `client secret`, etc which are required to load shop grades, product grades, etc
 */
public class TrustbadgeLibrary {


    // MARK: Public methods

    /**
     Calls TrustbadgeConfigurationService to load the required libary configuration details.
     */
    public static func configure() {
        do {
            try TrustbadgeConfigurationService.shared.loadConfiguration()
        } catch {
            TSConsoleLogger.log(
                messege: "Error loading trustbadge configuration. Please check if the application has valid TrustbadgeConfiguration.plist file with required key value pairs. Trustbadge library's Git project readme has more details about the required configuration file.",
                severity: .error
            )
        }
    }
}
