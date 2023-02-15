//
//  TrustmarkDataServiceTests.swift
//  TrustylibTests
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

    func testTrustmarkDataServiceReturnsDetailsForInvalidTSID() throws {
        let trustmarkExpectation = expectation(description: "TrustmarkDataService response expectation")
        self.trustmarkDataService.getTrustmarkDetails(for: "testTSID") { didLoadDetails in
            self.didLoadTrustmarkDetails = didLoadDetails
            trustmarkExpectation.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertFalse(self.didLoadTrustmarkDetails,
                       "TrustmarkDataService shouldn't return trustmark details for an invalid TSID")
    }

    func testTrustmarkDataServiceReturnsDetailsForValidTSID() throws {
        let trustmarkExpectation = expectation(description: "TrustmarkDataService response expectation")
        self.trustmarkDataService.getTrustmarkDetails(for: "X330A2E7D449E31E467D2F53A55DDD070") { didLoadDetails in
            self.didLoadTrustmarkDetails = didLoadDetails
            trustmarkExpectation.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertTrue(self.didLoadTrustmarkDetails,
                       "TrustmarkDataService should return trustmark details for a valid TSID")
        XCTAssertNotNil(trustmarkDataService.trustMarkDetails, "Trustmark shouldn't be nil for a valid TSID")
    }
}
