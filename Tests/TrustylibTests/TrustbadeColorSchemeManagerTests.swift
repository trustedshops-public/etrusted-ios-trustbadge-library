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
//  Created by Prem Pratap Singh on 20/06/23.
//


import XCTest
import SwiftUI
@testable import Trustylib

/**
 TrustbadeColorSchemeManagerTests tests the TrustbadeColorSchemeManager workflows for
 updating library widgets' color and assets
 */
final class TrustbadeColorSchemeManagerTests: XCTestCase {
    
    func testTrustbadeColorSchemeManagerUpdatesColorsBasedOnActiveColorScheme() throws {
        let manager = TrustbadgeColorSchemeManager.instance
        manager.updateColorsForScheme(.dark)
        XCTAssertTrue(
            manager.borderColor.description == Color.tsGray700.description,
            "TrustbadgeColorSchemeManager should update color codes based on active color scheme"
        )
        XCTAssertTrue(
            manager.backgroundColor.description == Color.tsGray800.description,
            "TrustbadgeColorSchemeManager should update color codes based on active color scheme"
        )
        XCTAssertTrue(
            manager.titleTextColor.description == Color.white.description,
            "TrustbadgeColorSchemeManager should update color codes based on active color scheme"
        )
        XCTAssertTrue(
            manager.ratingTextColor.description == Color.white.description,
            "TrustbadgeColorSchemeManager should update color codes based on active color scheme"
        )
        XCTAssertTrue(
            manager.ratingRangeTextColor.description == Color.white.description,
            "TrustbadgeColorSchemeManager should update color codes based on active color scheme"
        )
    }
    
    func testCorrectColorSchemeIsSetForGivenSchemeName() {
        let manager = TrustbadgeColorSchemeManager.instance
        manager.testSettingTrustbadgeSchemeFor(schemeName: TrustbadgeColorScheme.light.name)
        XCTAssert(
            manager.trustbadgeColorScheme == .light,
            "TrustbadgeColorSchemeManager should set correct color scheme for the given scheme name"
        )
        
        manager.testSettingTrustbadgeSchemeFor(schemeName: TrustbadgeColorScheme.dark.name)
        XCTAssert(
            manager.trustbadgeColorScheme == .dark,
            "TrustbadgeColorSchemeManager should set correct color scheme for the given scheme name"
        )
    }
}
