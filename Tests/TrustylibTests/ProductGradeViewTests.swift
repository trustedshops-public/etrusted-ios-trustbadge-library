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
    
    func testProductGradeViewInitializesWithCorrectValues() throws {
        let productGradeView = ProductGradeView(
            channelId: self.channelId,
            productId: self.productId,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        
        XCTAssert(
            productGradeView.channelId == self.channelId,
            "ProductGradeView should set correct channel id during initialization"
        )
        XCTAssert(
            productGradeView.currentState == self.state,
            "ProductGradeView should set correct state during initialization"
        )
        XCTAssert(
            productGradeView.alignment == self.alignment,
            "ProductGradeView should set correct alignment during initialization"
        )
        XCTAssertNotNil(
            productGradeView.currentViewModel,
            "ProductGradeView should initialize ProductGradeViewModel during initialization"
        )
        
        let lPadding = productGradeView.alignment == .leading ? productGradeView.height + productGradeView.hPadding : productGradeView.hPadding
        XCTAssert(
            productGradeView.lPadding == lPadding,
            "ProductGradeView should calcualate leading padding correctly based on the alignment property"
        )
        
        let tPadding = productGradeView.alignment == .leading ? productGradeView.hPadding : productGradeView.height + productGradeView.hPadding
        XCTAssert(
            productGradeView.tPadding == tPadding,
            "ProductGradeView should calcualate trailing padding correctly based on the alignment property"
        )
    }
    
    func testProductGradeViewBodyIsNotNil() {
        let productGradeView = ProductGradeView(
            channelId: self.channelId,
            productId: self.productId,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        XCTAssertNotNil(
            productGradeView.body,
            "ProductGradeView body value should not be nil"
        )
    }
}
