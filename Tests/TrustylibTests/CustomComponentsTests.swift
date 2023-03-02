//
//  CustomComponentsTests.swift
//  TrustylibTests
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
