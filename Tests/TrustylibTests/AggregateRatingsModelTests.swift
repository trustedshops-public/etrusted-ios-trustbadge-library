//
//  AggregateRatingsModelTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 15/02/23.
//

import XCTest
@testable import Trustylib

typealias AggregateRatingsResponseHandler = ([ShopAggregateRatingsModel]?, Error?) -> Void

/**
 This test suite tests decoding of aggregate ratings service respons JSON to `ShopAggregateRatingsModel` data object
 */
final class AggregateRatingsModelTests: XCTestCase {
    private var aggregateRatingsModel: ShopAggregateRatingsModel?

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
        XCTAssertTrue(aggregateRatings.nintyDaysRating.rating == 3.5,
                       "Aggregate ratings data object should have valid rating for nintyDaysRating")
        XCTAssertTrue(aggregateRatings.oneYearRating.rating == 4.4,
                       "Aggregate ratings data object should have valid rating for oneYearRating")
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
