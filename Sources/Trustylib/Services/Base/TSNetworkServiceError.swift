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
