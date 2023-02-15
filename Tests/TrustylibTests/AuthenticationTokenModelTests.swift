//
//  AuthenticationTokenModelTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 14/02/23.
//

import XCTest
@testable import Trustylib

typealias AuthenticationTokenResponseHandler = ([AuthenticationTokenModel]?, Error?) -> Void

/**
 This test suite tests decoding of authentication service respons JSON to `AuthenticationTokenModel` data object
 */
final class AuthenticationTokenModelTests: XCTestCase {

    private var authenticationTokenModel: AuthenticationTokenModel?

    override func setUpWithError() throws {
        self.getModalObjectForAuthenticationServiceMockResponse()
    }

    override func tearDownWithError() throws {
        self.authenticationTokenModel = nil
    }

    func testAuthenticationServiceResponseIsDecodedAsValidDataObject() throws {
        XCTAssertNotNil(self.authenticationTokenModel,
                        "Authentication service response json fails to decode as AuthenticationTokenModel")
    }

    func testAuthenticationTokenObjectHasValidValues() {
        guard let authenticationToken = self.authenticationTokenModel else {
            XCTFail("Authentication service response json fails to decode as AuthenticationTokenModel")
            return
        }

        XCTAssertFalse(authenticationToken.accessToken.isEmpty,
                       "Authentication data object should have valid token value")
        XCTAssertFalse(authenticationToken.scope.isEmpty,
                       "Authentication data object should have valid scope value")
        XCTAssertFalse(authenticationToken.tokenType.isEmpty,
                       "Authentication data object should have valid token type value")
        XCTAssertTrue(authenticationToken.expiresIn > 0,
                      "Authentication data object should have non zero expires in value")
        XCTAssertFalse(authenticationToken.isTokenExpired,
                       "Authentication data object should return isTokenExpired as false" )
    }

    // MARK: Helper methods

    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `AuthenticationTokenModel`
     object after encoding the json data
     */
    private func getModalObjectForAuthenticationServiceMockResponse() {
        let responseHandler: AuthenticationTokenResponseHandler = { response, error in
            guard error == nil,
                  let dataResponse = response,
                  let authenticatioModel = dataResponse.first else {
                return
            }
            self.authenticationTokenModel = authenticatioModel
        }

        let fileDataLoader = FileDataLoader()
        fileDataLoader.getData(for: .authenticationServiceResponse,
                                extenson: .json,
                                responseHandler: responseHandler)
    }
}
