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
