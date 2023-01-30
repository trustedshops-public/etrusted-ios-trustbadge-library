//
//  TrustylibConfigurationService.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustylibConfigurationService looks for the trustylib configuration plist file for collecting important
 details like client id, client secret, etc. If the configuration plist is found, it reads the given values and
 makes them available to other services. Else, it throws an error about missing configuration file.
 */

class TrustylibConfigurationService {

    // MARK: Public properties

    /// Returns singleton instance of the TrustylibConfigurationService
    static let shared = TrustylibConfigurationService()
    
    public private(set) var clientId: String?
    public private(set) var clientSecret: String?

    // MARK: Initializer

    private init() {}

    // MARK: Public methods

    /**
     This method looks for TrustylibConfiguration.plist file to load badge configuration details.
     If the file is not found, it throws an error to notify the host application about missing configuration file.
     */
    func loadConfiguration() throws {
        guard let path = Bundle.main.path(forResource: TrustylibConfigurationFileKeys.fileName,
                                          ofType: TrustylibConfigurationFileKeys.fileExtension),
              let configuration = NSDictionary(contentsOfFile: path) else {
            throw TrustylibError.configurationFileNotFound
        }

        guard let clientId = configuration[TrustylibConfigurationFileKeys.clientId] as? String else {
            throw TrustylibError.clientIdNotFound
        }

        guard let clientSecret = configuration[TrustylibConfigurationFileKeys.clientSecret] as? String else {
            throw TrustylibError.clientSecretNotFound
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
 TrustylibConfigurationFileKeys defines key names used in the trustylib configuration plist file.
 These key names are used to collect values from the configuration plist file.
 */
struct TrustylibConfigurationFileKeys {
    static let fileName = "TrustylibConfiguration"
    static let fileExtension = "plist"
    static let clientId = "ClientId"
    static let clientSecret = "ClientSecret"
}
