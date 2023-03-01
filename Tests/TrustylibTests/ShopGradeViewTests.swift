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
 This test suite tests `ShopGradeView`'s initialization workflow and the UI structure
 */
final class ShopGradeViewTests: XCTestCase {
    
    let channelId = "chl-b309535d-baa0-40df-a977-0b375379a3cc"
    let state: TrustbadgeState = .default(false)
    let alignment: TrustbadgeViewAlignment = .leading
    let width: CGFloat = 300
    let height: CGFloat = 75
    
    func testShopGradeViewInitializesWithCorrectValues() throws {
        let shopGradeView = ShopGradeView(
            channelId: self.channelId,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        
        XCTAssert(
            shopGradeView.channelId == self.channelId,
            "ShopGradeView should set correct channel id during initialization"
        )
        XCTAssert(
            shopGradeView.currentState == self.state,
            "ShopGradeView should set correct state during initialization"
        )
        XCTAssert(
            shopGradeView.alignment == self.alignment,
            "ShopGradeView should set correct alignment during initialization"
        )
        XCTAssertNotNil(
            shopGradeView.currentViewModel,
            "ShopGradeView should initialize ShopGradeViewModel during initialization"
        )
        
        let lPadding = shopGradeView.alignment == .leading ? shopGradeView.height + shopGradeView.hPadding : shopGradeView.hPadding
        XCTAssert(
            shopGradeView.lPadding == lPadding,
            "ShopGradeView should calcualate leading padding correctly based on the alignment property"
        )
        
        let tPadding = shopGradeView.alignment == .leading ? shopGradeView.hPadding : shopGradeView.height + shopGradeView.hPadding
        XCTAssert(
            shopGradeView.tPadding == tPadding,
            "ShopGradeView should calcualate trailing padding correctly based on the alignment property"
        )
    }
    
    func testShopGradeViewBodyIsNotNil() {
        let shopGradeView = ShopGradeView(
            channelId: self.channelId,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        XCTAssertNotNil(
            shopGradeView.body,
            "ShopGradeView body value should not be nil"
        )
    }
}
