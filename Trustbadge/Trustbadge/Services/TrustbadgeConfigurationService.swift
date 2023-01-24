//
//  TrustbadgeConfigurationService.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustbadgeConfigurationService looks for the trustbadge configuration plist file for collecting important
 details like client id, client secret, etc. If the configuration plist is found, it reads the given values and
 makes them available to other services. Else, it throws an error about missing configuration file.
 */

class TrustbadgeConfigurationService {

    // MARK: Public properties

    /// Returns singleton instance of the TrustbadgeConfigurationService
    static let shared = TrustbadgeConfigurationService()
    
    public private(set) var clientId: String?
    public private(set) var clientSecret: String?

    // MARK: Initializer

    private init() {}

    // MARK: Public methods

    /**
     This method looks for TrustbadgeConfiguration.plist file to load badge configuration details.
     If the file is not found, it throws an error to notify the host application about missing configuration file.
     */
    func loadConfiguration() throws {
        guard let path = Bundle.main.path(forResource: TrustbadgeConfigurationFileKeys.fileName,
                                          ofType: TrustbadgeConfigurationFileKeys.fileExtension),
              let configuration = NSDictionary(contentsOfFile: path) else {
            throw TrustbadgeError.configurationFileNotFound
        }

        guard let clientId = configuration[TrustbadgeConfigurationFileKeys.clientId] as? String else {
            throw TrustbadgeError.clientIdNotFound
        }

        guard let clientSecret = configuration[TrustbadgeConfigurationFileKeys.clientSecret] as? String else {
            throw TrustbadgeError.clientSecretNotFound
        }

        TSConsoleLogger.log(
            messege: "Successfully loaded client id and secret from the configuration file",
            severity: .info
        )
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}

/**
 TrustbadgeConfigurationFileKeys defines key names used in the trustbadge configuration plist file.
 These key names are used to collect values from the configuration plist file.
 */
struct TrustbadgeConfigurationFileKeys {
    static let fileName = "TrustbadgeConfiguration"
    static let fileExtension = "plist"
    static let clientId = "ClientId"
    static let clientSecret = "ClientSecret"
}
