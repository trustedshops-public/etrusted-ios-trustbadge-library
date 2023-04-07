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
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
import SwiftUI

@testable import Trustylib

/**
 This test suite tests initialization workflow and the UI structure for different custom UI components
 */
final class CustomComponentsTests: XCTestCase {

    func testStarRatingViewBodyIsNotNil() throws {
        let starRatingView = StarRatingView(rating: 4.7)
        XCTAssertNotNil(
            starRatingView.body,
            "StarRatingView body should not be nil"
        )
    }
    
    func testStarRatingViewSupportsDifferentFillRatio() {
        let starRatingView = StarRatingView(rating: 4.7)
        XCTAssertNotNil(
            starRatingView.fullStarView,
            "StarRatingView fullStarView should not be nil"
        )
        XCTAssertNotNil(
            starRatingView.halfFullStarView,
            "StarRatingView halfFullStarView should not be nil"
        )
        XCTAssertNotNil(
            starRatingView.emptyStarView,
            "StarRatingView emptyStarView should not be nil"
        )
    }
    
    func testStarViewPathIsNotNil() {
        let starView = StarView(corners: 5, smoothness: 0.10)
        let path = starView.path(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        XCTAssertNotNil(
            path,
            "StarView path shouldn't be nil"
        )
    }
    
    func testTrustylibCustomColorsAreValid() {
        XCTAssert(
            Color.tsGray100.description == "#E6F7FAFF",
            "Trustylib tsGray100 color should have the correct color code"
        )
        
        XCTAssert(
            Color.tsPineapple500.description == "#FFDB0DFF",
            "Trustylib tsPineapple500 color should have the correct color code"
        )
    }
}
