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

typealias AggregateRatingsResponseHandler = ([AggregateRatingsModel]?, Error?) -> Void

/**
 This test suite tests decoding of aggregate ratings service respons JSON to `ShopAggregateRatingsModel` data object
 */
final class AggregateRatingsModelTests: XCTestCase {
    private var aggregateRatingsModel: AggregateRatingsModel?

    override func setUpWithError() throws {
        self.getModalObjectForAggregateRatingsServiceMockResponse()
    }

    override func tearDownWithError() throws {
        self.aggregateRatingsModel = nil
    }

    func testAggregateRatingsServiceResponseIsDecodedAsValidDataObject() throws {
        XCTAssertNotNil(self.aggregateRatingsModel,
                        "Aggregate ratings service response json fails to decode as ShopAggregateRatingsModel")
    }

    func testAggregateRatingsObjectHasValidValues() {
        guard let aggregateRatings = self.aggregateRatingsModel else {
            XCTFail("Aggregate ratings service response json fails to decode as ShopAggregateRatingsModel")
            return
        }

        XCTAssertTrue(aggregateRatings.sevenDaysRating.rating == 0,
                       "Aggregate ratings data object should have valid rating for oneYearRating")
        XCTAssertTrue(aggregateRatings.thirtyDaysRating.count == 0,
                       "Aggregate ratings data object should have valid count for thirtyDaysRating")
        XCTAssertTrue(aggregateRatings.thirtyDaysRating.grade == "Very poor",
                       "Aggregate ratings data object should have valid grade for thirtyDaysRating")
        
        XCTAssertTrue(aggregateRatings.nintyDaysRating.rating == 3.5,
                       "Aggregate ratings data object should have valid rating for nintyDaysRating")
        XCTAssertTrue(aggregateRatings.nintyDaysRating.grade == "Good",
                       "Aggregate ratings data object should have valid grade for nintyDaysRating")
        
        XCTAssertTrue(aggregateRatings.oneYearRating.rating == 4.4,
                       "Aggregate ratings data object should have valid rating for oneYearRating")
        XCTAssertTrue(aggregateRatings.oneYearRating.grade == "Good",
                       "Aggregate ratings data object should have valid rating for oneYearRating")
        XCTAssertTrue(aggregateRatings.oneYearRating.ratingFormatted == "4.40",
                       "Aggregate ratings data object should have correct formatted rating for oneYearRating")
        
        XCTAssertTrue(aggregateRatings.overallRating.count == 70,
                       "Aggregate ratings data object should have valid count for overallRating")
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `ShopAggregateRatingsModel`
     object after encoding the json data
     */
    private func getModalObjectForAggregateRatingsServiceMockResponse() {
        let responseHandler: AggregateRatingsResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let aggregateRatingsModel = dataResponse.first else {
                return
            }
            self.aggregateRatingsModel = aggregateRatingsModel
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: .aggregateRatingsServiceResponse,
                                extenson: .json,
                                responseHandler: responseHandler)
    }
}
