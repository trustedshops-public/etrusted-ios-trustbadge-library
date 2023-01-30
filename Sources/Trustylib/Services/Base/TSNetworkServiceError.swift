//
//  TSNetworkServiceError.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/*
 TSError protocol defines generic API for different error types
 */
protocol TSError: Error {

    // MARK: Public Properties

    var description: String { get }
}

/**
 TSNetworkServiceError defines properties for TS backend service call related errors. These errors help
 in identifying specific backend call related issues.
 */
class TSNetworkServiceError {
    var type: TSErrorType = .serverError
    var code: Int = 500

    init(type: TSErrorType, code: Int) {
        self.type = type
        self.code = code
    }
}

/**
 TSErrorType enumeration defines common error types and their description.
 */
enum TSErrorType: String, TSError {
    case badRequestParameter = "Request has invalid parameters"
    case internalError = "Network call failed due to some internal error"
    case serverError = "Error occurred while connecting to the server"
    case unexpectedResponseError = "Server returned unexpected response"
    case jsonParsingError = "Unable to parse server response"
    case nilResponseError = "Server didn't return any response"

    var description: String {
        return self.rawValue
    }
}
