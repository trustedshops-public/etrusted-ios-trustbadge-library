//
//  Copyright (C) 2023 Trusted Shops GmbH
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
 This test suite tests clent authentication worklow with `TSAuthenticationService`
 for different use cases.
 */

final class ClientAuthenticationTests: XCTestCase {

    override func setUpWithError() throws {
        TrustbadgeConfigurationService.shared.resetConfiguration()
    }

    func testClientAuthenticationFailsWithoutTrustbadgeConfiguration() throws {
        // Attempting to authenticate client without required trustbadge configuration
        TSAuthenticationService.shared.getAuthenticationToken { didAuthenticate in
            XCTAssertFalse(didAuthenticate,
                           "Client authentication should fail without prior trustbadge configuration")
        }
    }

    func testClientAuthenticationSucceedsAfterTrustbadgeConfiguration() throws {
        do {
            // Loading trustbadge configuration
            TrustbadgeConfigurationService.shared.resetConfiguration()
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)

            // Authenticating client
            let accessTokenExpectation = expectation(description: "Client authentication returns valid access token")
            TSAuthenticationService.shared.getAuthenticationToken { didAuthenticate in
                XCTAssertTrue(didAuthenticate, "Client authentication should succeed after trustbadge configuration")
                accessTokenExpectation.fulfill()
            }

            waitForExpectations(timeout: 3)
            XCTAssertNotNil(TSAuthenticationService.shared.accessToken,
                            "Client authentication failed to fetch access token")
            XCTAssertFalse(TSAuthenticationService.shared.isAccessTokenExpired,
                           "Client authentication failed to fetch valid token expiry time")
        } catch {
            XCTFail("Client authentication failed due to missing trustbadge configuration")
        }
    }
}
