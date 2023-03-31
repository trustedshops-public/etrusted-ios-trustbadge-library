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
//  Created by Prem Pratap Singh on 31/03/23.
//


import XCTest
@testable import Trustylib

/**
 TSNetworkDataServiceTests tests the backend API call related workflows like http requests, response codes, etc
 */
final class TSNetworkDataServiceTests: XCTestCase {
    
    func testNetworkDataServiceAddsCorrectURLParameters() {
        let parameters: [String: Any] = [
            "testParam1" : "testValue1",
            "testParam2" : "testValue2"
        ]
        
        let networkRequest = TSNetworkServiceRequest(
            url: URL(string: "http://test.com/testEndpoint")!,
            method: TSNetworkServiceMethod.get,
            parameters: parameters,
            body: nil,
            headerValues: nil)

        let apiResponseHandler: TSNetworkServiceResponseHandler<Bool> = { _, _ in }
        let responseConfiguration = TSNetworkServiceResponseConfiguration(
            hasResponseData: true,
            expectedResponseCode: .expected(200),
            unexpectedResponseCode: .unexpected(400),
            errorResponseCode: .error(500)
        )

        let testDataService = TestNetworkDataService()
        let urlSession = testDataService.getData(
            request: networkRequest,
            responseConfiguration: responseConfiguration,
            responseHandler: apiResponseHandler
        )
        
        let url = urlSession?.currentRequest?.url?.absoluteString
        XCTAssertTrue(
            url == "http://test.com/testEndpoint?testParam1=testValue1&testParam2=testValue2",
            "TSNetworkDataService should add correct query paramaters to the service URL"
        )
    }
    
    func testNetworkDataServiceShouldReturnCorrectUnexpectedErrorCode() {
        let networkRequest = TSNetworkServiceRequest(
            url: URL(string: "https://cdn1.api.trustedshops.com/shops/TestTSID/mobiles/v1/sdks/ios/trustmarks.json")!,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: nil)

        let networkErrorCodeExpectation = expectation(
            description: "Data service network error code expectation"
        )
        var networkErrorCode = 0
        let apiResponseHandler: TSNetworkServiceResponseHandler<Bool> = { _, error in
            guard let error = error else {
                return
            }
            networkErrorCode = error.code
            networkErrorCodeExpectation.fulfill()
        }
        let responseConfiguration = TSNetworkServiceResponseConfiguration(
            hasResponseData: true,
            expectedResponseCode: .expected(200),
            unexpectedResponseCode: .unexpected(404),
            errorResponseCode: .error(500)
        )

        let testDataService = TestNetworkDataService()
        let _ = testDataService.getData(
            request: networkRequest,
            responseConfiguration: responseConfiguration,
            responseHandler: apiResponseHandler
        )
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            networkErrorCode == 404,
            "TSNetworkDataService should return correct error code for unexpected response"
        )
    }
}

class TestNetworkDataService: TSNetworkDataService {}
