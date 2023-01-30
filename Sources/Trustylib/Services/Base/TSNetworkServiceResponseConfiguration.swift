//
//  TSNetworkServiceResponseConfiguration.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 TSNetworkServiceResponseConfiguration controls how the `TSNetworkDataService getData()` method
 responds to the response returned via the API call. Some API endpoints just return a response code not a valid JSON
 data whereas other endpoints return both response code and JSON data,  so by passing
 `true/false value for hasResponseData property`, we could generalize the response handling of
 TSNetworkDataService.

 The same way we could pass different response code for different API endpoints so that the service layer could
 handle different response code gracefully.
 */
class TSNetworkServiceResponseConfiguration {

    // MARK: Public properties
    var hasResponseData = true
    var expectedResponseCode: TSNetworkServiceResponseCode = .expected(200)
    var unexpectedResponseCode: TSNetworkServiceResponseCode = .unexpected(201)
    var errorResponseCode: TSNetworkServiceResponseCode = .error(501)

    // MARK: Initializer
    init(
        hasResponseData: Bool,
        expectedResponseCode: TSNetworkServiceResponseCode,
        unexpectedResponseCode: TSNetworkServiceResponseCode,
        errorResponseCode: TSNetworkServiceResponseCode) {

            self.hasResponseData = hasResponseData
            self.expectedResponseCode = expectedResponseCode
            self.unexpectedResponseCode = unexpectedResponseCode
            self.errorResponseCode = errorResponseCode
        }
}

/**
 TSNetworkServiceResponseCode enumeration defines different types of response code which
 Trustedshop's backend service API endpoints could return. These types are,
 `expected` response code represents the code which we expects from endpoint for a successful
 backend operation
 `unexpected` response code represents an unexpected response from backend - may be a bad r
 esponse or unexpecteed response
 `error` response code represents backend internal error event
 */
enum TSNetworkServiceResponseCode {
    case expected(Int)
    case unexpected(Int)
    case error(Int)

    var code: Int {
        switch self {
        case .expected(let code):
            return code
        case .unexpected(let code):
            return code
        case .error(let code):
            return code
        }
    }
}
