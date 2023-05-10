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
@testable import Trustylib

/**
 This test suite tests the `ShopGradeViewModel` related workflows for initialization and data load.
 */
final class ShopGradeViewModelTests: XCTestCase {

    func testShopGradeViewModelInitializesWithDefaultRatingAndGrade() {
        let viewModel = ShopGradeViewModel()
        XCTAssert(
            viewModel.shopGrade == "",
            "ShopGradeViewModel should be initialized with empty grade text"
        )
        XCTAssert(
            viewModel.shopRating == 0,
            "ShopGradeViewModel should be initialized with 0 rating"
        )
        XCTAssert(
            viewModel.shopRatingFormatted == "",
            "ShopGradeViewModel should be initialized with empty shopRatingFormatted text"
        )
    }
    
    func testShopGradeViewModelReturnsValidAggregateRatingsForGivenChannelId() throws {
        let viewModel = ShopGradeViewModel()
        let aggregateRatingExpectation = expectation(description: "Shop aggregate rating expectation")
        viewModel.loadShopGrade(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { _ in
            aggregateRatingExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 6)
        XCTAssert(
            viewModel.shopRating != 0,
            "ShopGradeViewModel should return valid aggregate rating for the given channel id"
        )
    }
    
    func testShopGradeViewModelDoesntReturnsAggregateRatingsForInvalidChannelId() throws {
        let viewModel = ShopGradeViewModel()
        let aggregateRatingExpectation = expectation(description: "Shop aggregate rating expectation")
        viewModel.loadShopGrade(for: "TestChannel") { _ in
            aggregateRatingExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 6)
        XCTAssert(
            viewModel.shopRating == 0,
            "ShopGradeViewModel should not return aggregate rating for an invalid channel id"
        )
    }
    
    func testShopGradeViewModelDoesntReturnsAggregateGradeForEmptyChannelId() throws {
        let viewModel = ShopGradeViewModel()
        let aggregateGradeExpectation = expectation(description: "Shop aggregate grade expectation")
        viewModel.loadShopGrade(for: "") { _ in
            aggregateGradeExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 6)
        XCTAssert(
            viewModel.shopGrade == "",
            "ShopGradeViewModel should not return aggregate grade for an empty channel id"
        )
    }
}
