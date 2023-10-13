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
//  Created by Prem Pratap Singh on 30/03/23.
//


import XCTest
@testable import Trustylib

/**
 BuyerProtectionViewTests tests UI related workflows for buyer protection view like
 initialization, data states, and UI rendering.
 */
final class BuyerProtectionViewTests: XCTestCase {

    let tsid = "X330A2E7D449E31E467D2F53A55DDD070"
    let state: TrustbadgeState = .default(false)
    let alignment: TrustbadgeViewAlignment = .leading
    let width: CGFloat = 300
    let height: CGFloat = 75
    
    func testBuyerProtectionViewInitializesWithCorrectValues() throws {
        let buyerProtectionView = BuyerProtectionView(
            tsid: self.tsid,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        
        XCTAssert(
            buyerProtectionView.tsid == self.tsid,
            "BuyerProtectionView should set correct tsid during initialization"
        )
        XCTAssert(
            buyerProtectionView.currentState == self.state,
            "BuyerProtectionView should set correct state during initialization"
        )
        XCTAssert(
            buyerProtectionView.alignment == self.alignment,
            "BuyerProtectionView should set correct alignment during initialization"
        )
        XCTAssertNotNil(
            buyerProtectionView.currentViewModel,
            "BuyerProtectionView should initialize BuyerProtectionViewModel during initialization"
        )
        
        let lPadding = buyerProtectionView.alignment == .leading ? buyerProtectionView.height + buyerProtectionView.hPadding : buyerProtectionView.hPadding
        XCTAssert(
            buyerProtectionView.lPadding == lPadding,
            "BuyerProtectionView should calcualate leading padding correctly based on the alignment property"
        )
        
        let tPadding = buyerProtectionView.alignment == .leading ? buyerProtectionView.hPadding : buyerProtectionView.height + buyerProtectionView.hPadding
        XCTAssert(
            buyerProtectionView.tPadding == tPadding,
            "BuyerProtectionView should calcualate trailing padding correctly based on the alignment property"
        )
    }
    
    func testBuyerProtectionViewBodyIsNotNil() {
        let buyerProtectionView = BuyerProtectionView(
            tsid: self.tsid,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: nil
        )
        
        
        XCTAssertNotNil(
            buyerProtectionView.body,
            "BuyerProtectionView body value should not be nil"
        )
    }
    
    func testBuyerProtectionViewLoadsDetailsSuccessfully() {
        let buyerProtectionDetailsExpectation = expectation(description: "Buyer protection expectation")
        let viewDelegate = MockBuyerProtectionViewDelegate(expectation: buyerProtectionDetailsExpectation)
        
        let buyerProtectionView = BuyerProtectionView(
            tsid: self.tsid,
            currentState: self.state,
            alignment: self.alignment,
            isTrustmarkValid: false,
            height: self.height,
            width: self.width,
            delegate: viewDelegate
        )
        buyerProtectionView.loadDetailsForTests()
        
        waitForExpectations(timeout: 6)
        XCTAssertTrue(
            viewDelegate.didLoadDetails,
            "BuyerProtectionView should load buyer protection details successfully"
        )
    }
}

/**
 MockBuyerProtectionViewDelegate helps in testing the buyer protection data load delegation workflow
 */
class MockBuyerProtectionViewDelegate: BuyerProtectionViewDelegate {
    var didLoadDetails: Bool = false
    
    private var expectation: XCTestExpectation?
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func didLoadBuyerProtectionDetails(protectionAmountWithCurrencyCode: String) {
        self.didLoadDetails = true
        self.expectation?.fulfill()
    }
}
