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
//  Created by Prem Pratap Singh on 21/04/23.
//


import XCTest
@testable import Trustylib


/**
 ProductDetailsDataServiceTests tests backend API call workflow for loading product details and ratings
 with valid channel and product ids
 */
final class ProductDetailsDataServiceTests: XCTestCase {

    private let productDetailsDataService = ProductDetailsDataService()
    private var didLoadProductDetails = false
    private var didLoadProductRatings = false

    override func setUpWithError() throws {
        self.didLoadProductDetails = false
        self.didLoadProductRatings = false
    }

    func testProductDetailsServiceFailsWithoutValidChannelAndProductIds() throws {
        self.productDetailsDataService.getProductDetails(
            for: "",
            productId: "") { productDetails in
            XCTAssertNil(
                productDetails,
                "ProductDetailsDataService should fail without valid channel and product ids"
            )
        }
    }
    
    func testProductDetailsServiceFailsWithWrongChannelAndProductIds() throws {
        self.productDetailsDataService.getProductDetails(
            for: "mock-channel-id",
            productId: "mock-product-id") { productDetails in
            XCTAssertNil(
                productDetails,
                "ProductDetailsDataService should fail with wrong channel and product ids"
            )
        }
    }
    
    func testProductDetailsServiceReturnsValidDetails() {
        let productDetailsExpectation = expectation(description: "ProductDetailsDataService response expectation")
        self.productDetailsDataService.getProductDetails(
            for: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
            productId: "31303030") { details in
            self.didLoadProductDetails = details != nil
            productDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            self.didLoadProductDetails,
            "ProductDetailsDataService should return valid product details with given channel and product ids"
        )
    }
    
    func testProductDetailsServiceFailsToLoadRatingsWithoutValidChannelAndProductIds() throws {
        self.productDetailsDataService.getProductRatings(
            for: "",
            productId: "") { productRatings in
            XCTAssertNil(
                productRatings,
                "ProductDetailsDataService shouldn't load product ratigns without valid channel and product ids"
            )
        }
    }
    
    func testProductDetailsServiceFailsToLoadRatingsWithWrongChannelAndProductIds() throws {
        self.productDetailsDataService.getProductRatings(
            for: "mock-channel-id",
            productId: "mock-product-id") { productRatings in
            XCTAssertNil(
                productRatings,
                "ProductDetailsDataService shouldn't load product ratigns for wrong channel and product ids"
            )
        }
    }
    
    func testProductDetailsServiceLoadsValidProductRatings() {
        let productRatingDetailsExpectation = expectation(description: "ProductDetailsDataService response expectation")
        self.productDetailsDataService.getProductRatings(
            for: "chl-c0ad29ff-a086-4191-a663-82fed64f6f65",
            productId: "31303030") { details in
            self.didLoadProductRatings = details != nil
            productRatingDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            self.didLoadProductRatings,
            "ProductDetailsDataService should load valid product ratings with given channel and product ids"
        )
    }
}
