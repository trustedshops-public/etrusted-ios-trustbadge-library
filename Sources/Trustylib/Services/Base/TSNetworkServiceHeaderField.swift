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
 TSNetworkServiceHeaderField defines header field keys as expected by the Trustedshops
 backend services
 */
struct TSNetworkServiceHeaderField {
    static let authorization = "Authorization"
    static let accessToken = "Access-Token"
    static let contentType = "Content-Type"
    static let accept = "Accept"
}

/**
 TSNetworkServiceHeaderFieldValue defines values for header key as expected by the Trustedshops
 backend services
 */
struct TSNetworkServiceHeaderFieldValue {
    static let authorizationBearerToken = "Bearer %@"
    static let contentTypeJson = "application/json"
    static let contentTypeUrlEncoded = "application/x-www-form-urlencoded"
    static let acceptAll = "*/*"
}
