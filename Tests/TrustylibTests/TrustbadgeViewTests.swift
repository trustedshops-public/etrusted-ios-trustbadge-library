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
 This test suite tests `TrustbadgeView`'s initialization workflow and the UI structure
 */
final class TrustbadgeViewTests: XCTestCase {
    let tsId = "X330A2E7D449E31E467D2F53A55DDD070"
    let channelId = "chl-b309535d-baa0-40df-a977-0b375379a3cc"
    let productId = "46432d34333837383331"
    let context: TrustbadgeContext = .shopGrade
    
    func testTrustbadgeViewInitializesWithCorrectValues() throws {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: self.context)
        
        XCTAssertNotNil(
            trustbadgeView.currentViewModel,
            "TrustbadgeView should initialize view model during initialization"
        )
        
        XCTAssert(
            trustbadgeView.currentViewModel.tsId == self.tsId,
            "TrustbadgeView should set correct tsid during initialization"
        )
        
        XCTAssert(
            trustbadgeView.currentViewModel.channelId == self.channelId,
            "TrustbadgeView should set correct channel id during initialization"
        )
        
        XCTAssert(
            trustbadgeView.currentViewModel.context == self.context,
            "TrustbadgeView should set correct context during initialization"
        )
    }
    
    func testTrustbadgeViewBodyIsNotNilForShopGradeContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: .shopGrade)
        XCTAssertNotNil(
            trustbadgeView.body,
            "TrustbadgeView body should not be nil for shop grade context"
        )
    }
    
    func testTrustbadgeViewRootViewIsNotNilForShopGradeContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: .shopGrade)
        let view = trustbadgeView.getTestRootViewWith(proposedWidth: 200, proposedHeight: 50)
        XCTAssertNotNil(
            view,
            "TrustbadgeView body should not be nil for shop grade context"
        )
    }
    
    func testTrustbadgeViewBodyIsNotNilForBuyerProtectionContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: .buyerProtection)
        XCTAssertNotNil(
            trustbadgeView.body,
            "TrustbadgeView body should not be nil for buyer protection context"
        )
    }
    
    func testTrustbadgeViewRootViewIsNotNilForBuyerProtectionContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: .buyerProtection)
        let view = trustbadgeView.getTestRootViewWith(proposedWidth: 200, proposedHeight: 50)
        XCTAssertNotNil(
            view,
            "TrustbadgeView body should not be nil for buyer protection context"
        )
    }
    
    func testTrustbadgeViewRootViewIsnotNilForProductGradeContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            productId: self.productId,
            context: .productGrade)
        let view = trustbadgeView.getTestRootViewWith(proposedWidth: 200, proposedHeight: 50)
        XCTAssertNotNil(
            view,
            "TrustbadgeView body should not be nil for product grade context"
        )
    }
    
    func testTrustbadgeViewRootViewIsNotNilForProductGradeContext() {
        let trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            productId: self.productId,
            context: .productGrade)
        let view = trustbadgeView.getTestRootViewWith(proposedWidth: 200, proposedHeight: 50)
        XCTAssertNotNil(
            view,
            "TrustbadgeView body should not be nil for product grade context"
        )
    }
    
    func testTrustbadgeViewStateChangesToInvisibleWhenIsHiddenSetToTrue() {
        var trustbadgeView = TrustbadgeView(
            tsId: self.tsId,
            channelId: self.channelId,
            context: self.context)
        trustbadgeView.isHidden = true
        XCTAssertTrue(
            trustbadgeView.currentViewModel.currentState != .default(true),
            "Trustbadge view state should change to invisible when isHidden set to true"
        )
    }
}
