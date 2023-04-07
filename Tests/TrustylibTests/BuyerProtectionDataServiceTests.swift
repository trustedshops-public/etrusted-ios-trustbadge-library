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
 BuyerProtectionDataServiceTests tests buyer protection data load related workflows
 */
final class BuyerProtectionDataServiceTests: XCTestCase {

    private let buyerProtectionDataService = BuyerProtectionDataService()
    private var didLoadBuyerProtectionDetails = false
    
    override func setUpWithError() throws {
        self.didLoadBuyerProtectionDetails = false
    }
    
    func testBuyerProtectionDataServiceReturnsDetailsForValidTSID() throws {
        let buyerProtectionDetailsExpectation = expectation(
            description: "BuyerProtectionDataService response expectation"
        )
        self.buyerProtectionDataService.getBuyerProtectionDetails(
            for: "X330A2E7D449E31E467D2F53A55DDD070"
        ) { details in
            self.didLoadBuyerProtectionDetails = details != nil
            buyerProtectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            self.didLoadBuyerProtectionDetails,
            "BuyerProtectionDataService should return buyer protection details for a valid TSID"
        )
    }
    
    func testBuyerProtectionDataServiceReturnsNilForInvalidTSID() throws {
        let buyerProtectionDetailsExpectation = expectation(
            description: "BuyerProtectionDataService response expectation"
        )
        self.buyerProtectionDataService.getBuyerProtectionDetails(for: "testTSID") { details in
            self.didLoadBuyerProtectionDetails = details != nil
            buyerProtectionDetailsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertFalse(
            self.didLoadBuyerProtectionDetails,
            "BuyerProtectionDataService should return nil value for an invalid TSID"
        )
    }
}
