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

typealias BuyerProtectionDetailsServiceResponseHandler = ([BuyerProtectionBackendResponseModel]?, Error?) -> Void

/**
 BuyerProtectionDetailsModelTests tests the json encoding workflow for BuyerProtectionDetailsModel
 model object
 */
final class BuyerProtectionDetailsModelTests: XCTestCase {

    private var buyerProtectionDetailsModel: BuyerProtectionDetailsModel?

    override func setUpWithError() throws {
        self.getModalObjectForBuyerProtectionDetailsServiceMockResponse()
    }

    override func tearDownWithError() throws {
        self.buyerProtectionDetailsModel = nil
    }

    func testBuyerProtectionDetailsServiceResponseIsDecodedAsValidDataObject() throws {
        XCTAssertNotNil(self.buyerProtectionDetailsModel,
                        "Buyer protection details service response fails to decode as BuyerProtectionDetailsModel")
    }

    func testBuyerProtectionDetailsModelObjectHasValidValues() {
        guard let buyerProtectionDetailsModel = self.buyerProtectionDetailsModel else {
            XCTFail("Buyer protection details service response fails to decode as BuyerProtectionDetailsModel")
            return
        }

        XCTAssertTrue(buyerProtectionDetailsModel.tsId == "X330A2E7D449E31E467D2F53A55DDD070",
                       "Buyer protection details object should have correct TSID")
        XCTAssertTrue(buyerProtectionDetailsModel.name == "Trusted Shops DemoShop CH",
                       "Buyer protection details object should have correct shop name")
        XCTAssertTrue(buyerProtectionDetailsModel.guarantee.maxProtectionAmount == "4000.00",
                       "Buyer protection details object should have correct protection amount")
        XCTAssertTrue(buyerProtectionDetailsModel.guarantee.mainProtectionCurrency == "CHF",
                       "Buyer protection details object should have correct currency code")
        XCTAssertTrue(buyerProtectionDetailsModel.guarantee.maxProtectionDuration == "30",
                       "Buyer protection details object should have correct protection duration")
    }
    
    func testBuyerProtectionDetailsReturnsCorrectFormattedStringForProtectionAmount() {
        guard let buyerProtectionDetailsModel = self.buyerProtectionDetailsModel else {
            XCTFail("Buyer protection details service response fails to decode as BuyerProtectionDetailsModel")
            return
        }
        
        XCTAssertTrue(buyerProtectionDetailsModel.guarantee.maxProtectionAmount == "4000.00",
                       "Buyer protection details object should have correct protection amount")
        XCTAssertTrue(buyerProtectionDetailsModel.guarantee.protectionAmountFormatted == "€4,000",
                       "Buyer protection details object should return valid formatted protection amount")
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `BuyerProtectionDetailsModel`
     object after encoding the json data
     */
    private func getModalObjectForBuyerProtectionDetailsServiceMockResponse() {
        let responseHandler: BuyerProtectionDetailsServiceResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let buyerProtectionDetailsResponseModel = dataResponse.first else {
                return
            }
            self.buyerProtectionDetailsModel = buyerProtectionDetailsResponseModel.response.data.shop
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: .buyerProtectionDetailsServiceResponse,
                               extenson: .json,
                               responseHandler: responseHandler)
    }
}
