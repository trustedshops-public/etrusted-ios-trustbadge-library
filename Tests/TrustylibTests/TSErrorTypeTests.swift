//
//  TSErrorTypeTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 01/03/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests TS error properties
 */
final class TSErrorTests: XCTestCase {

    func testTSErrorReturnsCorrectDescription() throws {
        XCTAssert(
            TSErrorType.internalError.description == "Network call failed due to some internal error",
            "TSError should return correct description"
        )
        
        XCTAssert(
            TSErrorType.jsonParsingError.description == "Unable to parse server response",
            "TSError should return correct description"
        )
    }
}
