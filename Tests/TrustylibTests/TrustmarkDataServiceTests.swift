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
//  Created by Prem Pratap Singh on 14/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests shop's Trustmark details (name, certificate validity, etc) load
 related workflows using `TrustmarkDataService`
 */

final class TrustmarkDataServiceTests: XCTestCase {
    
    private let trustmarkDataService = TrustmarkDataService()
    private var didLoadTrustmarkDetails = false
    
    override func setUpWithError() throws {
        self.didLoadTrustmarkDetails = false
    }
    
    func testTrustmarkDataServiceReturnsNilForInvalidTSID() throws {
        let trustmarkExpectation = expectation(description: "TrustmarkDataService response expectation")
        self.trustmarkDataService.getTrustmarkDetails(for: "testTSID") { details in
            self.didLoadTrustmarkDetails = details != nil
            trustmarkExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertFalse(self.didLoadTrustmarkDetails,
                       "TrustmarkDataService should return nil value for an invalid TSID")
    }
    
    func testTrustmarkDataServiceReturnsDetailsForValidTSID() throws {
        let trustmarkExpectation = expectation(description: "TrustmarkDataService response expectation")
        self.trustmarkDataService.getTrustmarkDetails(for: "X330A2E7D449E31E467D2F53A55DDD070") { details in
            self.didLoadTrustmarkDetails = details != nil
            trustmarkExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(self.didLoadTrustmarkDetails,
                      "TrustmarkDataService should return trustmark details for a valid TSID")
    }
}
