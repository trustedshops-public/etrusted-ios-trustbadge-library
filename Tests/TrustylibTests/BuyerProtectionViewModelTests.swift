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
//  Created by Prem Pratap Singh on 30/03/23.
//


import XCTest
@testable import Trustylib

/**
 BuyerProtectionViewModelTests tests the buyer protection data load realted
 workflows.
 */
final class BuyerProtectionViewModelTests: XCTestCase {

    func testBuyerProtectionViewModelInitializesWithNilBuyerProtectionDetails() {
        let viewModel = BuyerProtectionViewModel()
        XCTAssertNil(
            viewModel.buyerProtectionDetails,
            "BuyerProtectionViewModel should be initialized with nil value for buyer protection details"
        )
    }
    
    func testBuyerProtectionViewModelReturnsValidDetailsForGivenTSID() throws {
        let viewModel = BuyerProtectionViewModel()
        let protectionDetailsExpectation = expectation(
            description: "Shop buyer protection details expectation"
        )
        viewModel.loadBuyerProtectionDetails(for: "X330A2E7D449E31E467D2F53A55DDD070") { _ in
            protectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        guard let buyerProtectionDetails = viewModel.buyerProtectionDetails else {
            XCTFail("BuyerProtectionViewModel should return valid buyer protection details for the given TSID")
            return
        }
        XCTAssert(
            buyerProtectionDetails.tsId == "X330A2E7D449E31E467D2F53A55DDD070",
            "BuyerProtectionViewModel should load protection details for correct TSID"
        )
    }
    
    func testBuyerProtectionViewModelReturnsReturnsNilForInvalidTSID() throws {
        let viewModel = BuyerProtectionViewModel()
        let protectionDetailsExpectation = expectation(
            description: "Shop buyer protection details expectation"
        )
        viewModel.loadBuyerProtectionDetails(for: "InvalidTSID") { _ in
            protectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(
            viewModel.buyerProtectionDetails,
            "BuyerProtectionViewModel shouldn't return buyer protection details for invalid TSID"
        )
    }
}
