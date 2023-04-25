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
//  Created by Prem Pratap Singh on 21/04/23.
//


import XCTest
@testable import Trustylib

typealias ProductRatingsResponseHandler = ([ProductRatingsModel]?, Error?) -> Void

/**
 ProductRatingsModelTests tests json decoding workflow of the product ratings data object and also
 validates object properties
 */
final class ProductRatingsModelTests: XCTestCase {
    private var productRatingsModel: ProductRatingsModel?

    override func setUpWithError() throws {
        self.getModalObjectForProductRatingsServiceMockResponse()
    }

    override func tearDownWithError() throws {
        self.productRatingsModel = nil
    }

    func testProductRatingsServiceResponseIsDecodedAsValidDataObject() throws {
        XCTAssertNotNil(self.productRatingsModel,
                        "Product ratings service response json fails to decode as ProductRatingsModel")
    }

    func testProductRatingsObjectHasValidValues() {
        guard let productRatings = self.productRatingsModel else {
            XCTFail("Product ratings service response json fails to decode as ProductRatingsModel")
            return
        }

        XCTAssertTrue(productRatings.grades.sevenDaysRating.rating == 4.5,
                       "Product ratings data object should have valid rating for seven day")
        XCTAssertTrue(productRatings.grades.sevenDaysRating.count == 2,
                       "Product ratings data object should have valid grade for seven day")
        XCTAssertTrue(productRatings.grades.sevenDaysRating.grade == "Excellent",
                       "Product ratings data object should return valid grade for seven day rating")
        XCTAssertTrue(productRatings.grades.sevenDaysRating.ratingFormatted == "4.50",
                       "Product ratings data object should return valid formatted rating")
        XCTAssertNotNil(productRatings.grades.thirtyDaysRating,
                        "Product ratings data object should have valid rating for thirty day")
        XCTAssertNotNil(productRatings.grades.nintyDaysRating,
                        "Product ratings data object should have valid rating for ninty day")
        XCTAssertNotNil(productRatings.grades.oneYearRating,
                        "Product ratings data object should have valid rating for one year")
        XCTAssertNotNil(productRatings.grades.overallRating,
                        "Product ratings data object should have valid overall ratings")
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `ProductRatingsModel`
     object after encoding the json data
     */
    private func getModalObjectForProductRatingsServiceMockResponse() {
        let responseHandler: ProductRatingsResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let productRatingsModel = dataResponse.first else {
                return
            }
            self.productRatingsModel = productRatingsModel
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: .productRatingsServiceResponse,
                                extenson: .json,
                                responseHandler: responseHandler)
    }

}
