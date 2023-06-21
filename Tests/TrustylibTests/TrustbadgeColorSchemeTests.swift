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
//  Created by Prem Pratap Singh on 20/06/23.
//


import XCTest
@testable import Trustylib

/**
 TrustbadgeColorSchemeTests tests the validity of properties for the active color scheme
 for the library
 */
final class TrustbadgeColorSchemeTests: XCTestCase {
    func testTrustbadgeColorSchemeReturnsCorrectName() throws {
        XCTAssertTrue(
            TrustbadgeColorScheme.light.name == "light",
            "TrustbadgeColorScheme should return correct schme name"
        )
        
        XCTAssertTrue(
            TrustbadgeColorScheme.dark.name == "dark",
            "TrustbadgeColorScheme should return correct schme name"
        )
        
        XCTAssertTrue(
            TrustbadgeColorScheme.system.name == "system",
            "TrustbadgeColorScheme should return correct schme name"
        )
    }
    
    func testTrustbadgeColorSchemeReturnsCorrectImageIconAssetName() throws {
        XCTAssertTrue(
            TrustbadgeColorScheme.light.iconImageName == "trustMarkIconInvalidCertificate-Light",
            "TrustbadgeColorScheme should return correct image asset name for active schme"
        )
        
        XCTAssertTrue(
            TrustbadgeColorScheme.dark.iconImageName == "trustMarkIconInvalidCertificate-Dark",
            "TrustbadgeColorScheme should return correct image asset name for active schme"
        )
        
        XCTAssertNil(
            TrustbadgeColorScheme.system.iconImageName,
            "TrustbadgeColorScheme should return nil for image asset name for system schme"
        )
    }
}
