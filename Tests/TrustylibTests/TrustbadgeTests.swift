//
//  TrustbadgeTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests the configuration workflow for the `Trustbadge.configure()` method
 */
final class TrustbadgeTests: XCTestCase {
    func testTrustbadgeConfigureLoadsTheCorrectConfiguration() throws {
        do {
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)
            Trustbadge.configure()
            XCTAssert(
                TrustbadgeConfigurationService.shared.clientId == "d197ed41db84__etrusted-ios-sdk",
                "Trustbadge should configure the library with correct client id")
            XCTAssert(
                TrustbadgeConfigurationService.shared.clientSecret == "96e87f24-230a-4704-997c-8f040849e5de",
                "Trustbadge should configure the library with correct client secret")
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
}
