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
