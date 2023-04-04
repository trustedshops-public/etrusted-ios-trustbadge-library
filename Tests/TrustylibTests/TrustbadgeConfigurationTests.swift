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
//  Created by Prem Pratap Singh on 14/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests the workflow for Trustbadge configuration which requires searching for
 the `TrustbadgeConfiguration.plist` file and fetching valid client id and client secret
 values from this plist file
 */

final class TrustbadgeConfigurationTests: XCTestCase {

    // MARK: Trustbadge configuration values

    private var clientId: String?
    private var clientSecret: String?

    override func setUpWithError() throws {
        self.loadTrustbadgeConfiguration()
    }

    override func tearDownWithError() throws {
        self.resetTrustbadgeConfiguration()
    }

    func testTrustbadgeConfigurationHasValidClientIdAndSecret() {
        guard let id = self.clientId else {
            XCTFail("Trustbadge configuration doesn't have client id value")
            return
        }

        guard let secret = self.clientSecret else {
            XCTFail("Trustbadge configuration doesn't have client secret value")
            return
        }

        XCTAssertFalse(id.isEmpty, "Trustbadge configuration has invalid client id value")
        XCTAssertFalse(secret.isEmpty, "Trustbadge configuration has invalid client secret value")
    }

    // MARK: Helper methods

    /**
     Calls TrustbadgeConfigurationService to load trustbadge configuration file and collects
     client id and client secret values
     */
    private func loadTrustbadgeConfiguration() {
        do {
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)
            self.clientId = TrustbadgeConfigurationService.shared.clientId
            self.clientSecret = TrustbadgeConfigurationService.shared.clientSecret
        } catch {
            guard let trustbadgeError = error as? TrustbadgeError else {
                XCTFail("Trustbadge configuration failed due to missing configuration PList file")
                return
            }
            if trustbadgeError == TrustbadgeError.configurationFileNotFound {
                XCTFail("Trustbadge configuration failed due to missing configuration PList file")
            } else if trustbadgeError == TrustbadgeError.clientIdNotFound {
                XCTFail("Trustbadge configuration failed due to missing client id")
            } else if trustbadgeError == TrustbadgeError.clientSecretNotFound {
                XCTFail("Trustbadge configuration failed due to missing client secret")
            }
        }
    }

    /**
     Resets the trustbadge configuration values
     */
    private func resetTrustbadgeConfiguration() {
        self.clientId = nil
        self.clientSecret = nil
    }
}
