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

/**
 TSNetworkServiceRequest defines structure of a request object used for calling Trustedshops's backend API
 */
struct TSNetworkServiceRequest {

    // MARK: Public Properties

    var url: URL
    var method: String
    var parameters: [String: Any]?
    var body: Data?
    var headerValues: [String: String]?
    var contentType: String

    // MARK: Initializer

    init(
        url: URL,
        method: String,
        parameters: [String: Any]? = nil,
        body: Data? = nil,
        headerValues: [String: String]? = nil,
        contentType: String = TSNetworkServiceHeaderFieldValue.contentTypeJson) {

            self.url = url
            self.method = method
            self.parameters = parameters
            self.body = body
            self.headerValues = headerValues
            self.contentType = contentType
        }
}
