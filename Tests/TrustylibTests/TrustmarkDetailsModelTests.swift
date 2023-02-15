//
//  TrustmarkDetailsModelTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 15/02/23.
//

import XCTest
@testable import Trustylib

typealias TrustmarkDetailsServiceResponseHandler = ([TrustmarkBackendResponseModel]?, Error?) -> Void

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
        let responseHandler: TrustmarkDetailsServiceResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let trustmarkDetailsResponseModel = dataResponse.first else {
                return
            }
            self.trustmarkDetailsModel = trustmarkDetailsResponseModel.response.data.shop
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: .trustmarkDetailsServiceResponse,
                                extenson: .json,
                                responseHandler: responseHandler)
    }

}
