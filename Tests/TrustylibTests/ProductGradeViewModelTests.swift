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
//  Created by Prem Pratap Singh on 20/04/23.
//


import XCTest
@testable import Trustylib

/**
 ProductGradeViewModelTests tests the view model workflows for communicating with `ProductDetailsDataService`
 to load product details and ratings.
 */
final class ProductGradeViewModelTests: XCTestCase {

    func testProductGradeViewModelInitializesWithDefaultRatingAndDetails() {
        let viewModel = ProductGradeViewModel()
        XCTAssert(
            viewModel.productRating == 0,
            "ProductGradeViewModel should be initialized with 0 rating value"
        )
        XCTAssert(
            viewModel.productGrade.isEmpty,
            "ProductGradeViewModel should be initialized with empty product grade text"
        )
        XCTAssert(
            viewModel.productImageUrl.isEmpty,
            "ProductGradeViewModel should be initialized with empty product image url"
        )
        XCTAssert(
            viewModel.productRatingFormatted.isEmpty,
            "ProductGradeViewModel should be initialized with empty productRatingFormatted text"
        )
    }
    
    func testProductGradeViewModelLoadsProductDetailsForGivenChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductDetails(
            for: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
            productId: "31303031") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            !viewModel.productImageUrl.isEmpty,
            "ProductGradeViewModel should load accurate product details for the given channel and product ids"
        )
    }
    
    func testProductGradeViewModelFailsToLoadsProductDetailsForWrongChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductDetails(
            for: "mock-channel-id",
            productId: "mock-product-id") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.productImageUrl.isEmpty,
            "ProductGradeViewModel should't load product details for wrong channel and product ids"
        )
    }
    
    func testProductGradeViewModelFailsToLoadsProductDetailsForEmptyChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductDetails(
            for: "",
            productId: "") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.productImageUrl.isEmpty,
            "ProductGradeViewModel should't load product details for empty channel and product ids"
        )
    }
    
    func testProductGradeViewModelLoadsProductRatingsForGivenChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductRating(
            for: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
            productId: "31303031") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.productRating != 0,
            "ProductGradeViewModel should load accurate product ratings for the given channel and product ids"
        )
    }
    
    func testProductGradeViewModelFailsToLoadsProductRatingsForWrongChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductRating(
            for: "mock-channel-id",
            productId: "mock-product-id") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.productRating == 0,
            "ProductGradeViewModel should't load product ratings for wrong channel and product ids"
        )
    }
    
    func testProductGradeViewModelFailsToLoadsProductRatingsForEmptyChannelAndProductId() throws {
        let viewModel = ProductGradeViewModel()
        let productDetailsExpectation = expectation(description: "Product details expectation")
        viewModel.loadProductRating(
            for: "",
            productId: "") { _ in
                productDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.productRating == 0,
            "ProductGradeViewModel should't load product details for empty channel and product ids"
        )
    }
}
