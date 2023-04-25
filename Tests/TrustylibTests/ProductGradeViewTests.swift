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
 ProductGradeViewTests tests initialization and UI rendering related workflows for product grade widget
 */
final class ProductGradeViewTests: XCTestCase {

    let channelId = "chl-c0ad29ff-a086-4191-a663-82fed64f6f65"
    let productId = "31303031"
    let state: TrustbadgeState = .default(false)
    let alignment: TrustbadgeViewAlignment = .leading
    let width: CGFloat = 300
    let height: CGFloat = 75
    var productGradeView: ProductGradeView?
    
    override func setUpWithError() throws {
        self.productGradeView = ProductGradeView(
            channelId: self.channelId,
            productId: self.productId,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
    }
    
    override func tearDownWithError() throws {
        self.productGradeView = nil
    }
    
    func testProductGradeViewInitializesWithCorrectValues() throws {
        XCTAssert(
            self.productGradeView?.channelId == self.channelId,
            "ProductGradeView should set correct channel id during initialization"
        )
        XCTAssert(
            self.productGradeView?.currentState == self.state,
            "ProductGradeView should set correct state during initialization"
        )
        XCTAssert(
            self.productGradeView?.alignment == self.alignment,
            "ProductGradeView should set correct alignment during initialization"
        )
        XCTAssertNotNil(
            self.productGradeView?.currentViewModel,
            "ProductGradeView should initialize ProductGradeViewModel during initialization"
        )
    }
    
    func testProductGradeViewBodyIsNotNil() {
        XCTAssertNotNil(
            self.productGradeView?.body,
            "ProductGradeView body value should not be nil"
        )
    }
    
    func testProductDetailsAndRatingLoad() {
        let productDetailsExpectation = expectation(description: "Product details expectation")
        var didLoadDetails = false
        self.productGradeView!.testLoadingOfProductDetailsAndRating { _ in
            didLoadDetails = true
            productDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            didLoadDetails,
            "ProductGradeViewM should load accurate product details for the given channel and product ids"
        )
    }
}
