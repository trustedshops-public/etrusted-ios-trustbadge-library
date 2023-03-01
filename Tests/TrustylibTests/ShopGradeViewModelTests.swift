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
 This test suite tests the `ShopGradeViewModel` related workflows for initialization and data load.
 */
final class ShopGradeViewModelTests: XCTestCase {

    func testShopGradeViewModelInitializesWithNilAggregateRating() {
        let viewModel = ShopGradeViewModel()
        XCTAssertNil(
            viewModel.shopAggregateRatings,
            "ShopGradeViewModel should be initialized with nil value for aggregate rating"
        )
    }
    
    func testShopGradeViewModelReturnsValidAggregateRatingsForGivenChannel() throws {
        do {
            // Loading trustbadge configuration
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)

            let viewModel = ShopGradeViewModel()
            let aggregateRatingExpectation = expectation(description: "Shop aggregate rating expectation")
            viewModel.loadAggregateRating(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { _ in
                aggregateRatingExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 6)
            XCTAssert(
                viewModel.shopAggregateRatings != nil,
                "ShopGradeViewModel should return valid aggregate rating for the given channel"
            )
        } catch {
            XCTFail("Failed to load shop grades due to missing trustbadge configuration")
        }
    }
    
    func testShopGradeViewModelReturnsNilAggregateRatingsForInvalidChannel() throws {
        do {
            // Loading trustbadge configuration
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)

            let viewModel = ShopGradeViewModel()
            let aggregateRatingExpectation = expectation(description: "Shop aggregate rating expectation")
            viewModel.loadAggregateRating(for: "TestChannel") { _ in
                aggregateRatingExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 6)
            XCTAssert(
                viewModel.shopAggregateRatings == nil,
                "ShopGradeViewModel should return nil aggregate rating for an invalid channel"
            )
        } catch {
            XCTFail("Failed to load shop grades due to missing trustbadge configuration")
        }
    }
    
    func testShopGradeViewModelAuthenticatesSuccessfully() throws {
        do {
            // Loading trustbadge configuration
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)

            let viewModel = ShopGradeViewModel()
            var didAuthenticateSuccessfully = false
            let authenticationExpectation = expectation(description: "Client authentication expectation")
            viewModel.getAuthenticationTokenIfNeeded { didAuthenticate in
                didAuthenticateSuccessfully = didAuthenticate
                authenticationExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 5)
            XCTAssertTrue(
                didAuthenticateSuccessfully,
                "TrustbadgeViewModel shouldn't set expended state for the trustmark context"
            )
        } catch {
            XCTFail("Failed to load shop grades due to missing trustbadge configuration")
        }
    }
}
