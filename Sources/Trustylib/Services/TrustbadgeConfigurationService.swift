//
//  Copyright (C) 2023 Trusted Shops AG
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustbadgeConfigurationService looks for the trustylib configuration plist file for collecting important
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
    func loadConfiguration(from bundle: Bundle) throws {
        guard let path = bundle.path(forResource: TrustbadgeConfigurationFileKeys.fileName,
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

    /**
     Resets the trustbadge configuration details to default values.
     This is used while running the tests which require to test service call failure without valid trustbadge configuration.
     */
    func resetConfiguration() {
        self.clientId = nil
        self.clientSecret = nil
    }
}

/**
 TrustylibConfigurationFileKeys defines key names used in the trustylib configuration plist file.
 These key names are used to collect values from the configuration plist file.
 */
struct TrustbadgeConfigurationFileKeys {
    static let fileName = "TrustbadgeConfiguration"
    static let fileExtension = "plist"
    static let clientId = "ClientId"
    static let clientSecret = "ClientSecret"
}
