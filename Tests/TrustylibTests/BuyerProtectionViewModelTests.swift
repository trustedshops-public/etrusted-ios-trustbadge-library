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
 BuyerProtectionViewModelTests tests the buyer protection data load realted
 workflows.
 */
final class BuyerProtectionViewModelTests: XCTestCase {

    func testBuyerProtectionViewModelInitializesWithDefaultBuyerProtectionDetails() {
        let viewModel = BuyerProtectionViewModel()
        XCTAssert(
            viewModel.protectionAmountFormatted == "",
            "BuyerProtectionViewModel should be initialized with empty protection details"
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
        XCTAssert(
            viewModel.protectionAmountFormatted != "",
            "BuyerProtectionViewModel should load protection details for correct TSID"
        )
    }
    
    func testBuyerProtectionViewModelDoesntReturnDetailsForInvalidTSID() throws {
        let viewModel = BuyerProtectionViewModel()
        let protectionDetailsExpectation = expectation(
            description: "Shop buyer protection details expectation"
        )
        viewModel.loadBuyerProtectionDetails(for: "InvalidTSID") { _ in
            protectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.protectionAmountFormatted == "",
            "BuyerProtectionViewModel shouldn't return buyer protection details for invalid TSID"
        )
    }
    
    func testBuyerProtectionViewModelDoesntReturnDetailsForEmptyTSID() throws {
        let viewModel = BuyerProtectionViewModel()
        let protectionDetailsExpectation = expectation(
            description: "Shop buyer protection details expectation"
        )
        viewModel.loadBuyerProtectionDetails(for: "") { _ in
            protectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.protectionAmountFormatted == "",
            "BuyerProtectionViewModel shouldn't return buyer protection details for empty TSID"
        )
    }
}
