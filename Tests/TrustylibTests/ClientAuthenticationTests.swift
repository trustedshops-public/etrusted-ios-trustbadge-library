//
//  ClientAuthenticationTests.swift
//  TrustylibTests
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
