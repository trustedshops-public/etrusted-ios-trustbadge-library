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
//  Created by Prem Pratap Singh on 15/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests decoding of trustmark details service respons JSON to `TrustmarkDetailsModel`  data object
 */
final class TrustmarkDetailsModelTests: XCTestCase {

    private var trustmarkDetailsModel: TrustmarkDetailsModel?

    override func setUpWithError() throws {
        self.getModalObjectForTrustmarkDetailsServiceMockResponse()
    }

    override func tearDownWithError() throws {
        self.trustmarkDetailsModel = nil
    }

    func testTrustmarkDetailsServiceResponseIsDecodedAsValidDataObject() throws {
        XCTAssertNotNil(self.trustmarkDetailsModel,
                        "Trustmark details service response json fails to decode as TrustmarkDetailsModel")
    }

    func testTrustmarkDetailsObjectHasValidValues() {
        guard let trustmarkDetails = self.trustmarkDetailsModel else {
            XCTFail("Trustmark details service response json fails to decode as TrustmarkDetailsModel")
            return
        }

        XCTAssertTrue(trustmarkDetails.tsId == "X330A2E7D449E31E467D2F53A55DDD070",
                       "Trustmark details data object should have valid TSID value")
        XCTAssertTrue(trustmarkDetails.name == "demoshop.trustedshops.com/ch",
                       "Trustmark details data object should have valid shop value")
        XCTAssertTrue(trustmarkDetails.trustMark.validFrom == "2016-02-04T00:00:00+01:00",
                       "Trustmark details data object should have valid date for validFrom value")
        XCTAssertTrue(trustmarkDetails.trustMark.validTo == "2017-02-03T00:00:00+01:00",
                       "Trustmark details data object should have valid date for validTo value")
        XCTAssertTrue(trustmarkDetails.trustMark.isValid,
                       "Trustmark details data object should return trustmark validity status")
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `TrustmarkDetailsModel`
     object after encoding the json data
     */
    private func getModalObjectForTrustmarkDetailsServiceMockResponse() {
        TestDataLoadWorker.getMockTrustmarkDetails { details in
            self.trustmarkDetailsModel = details
        }
    }
}
