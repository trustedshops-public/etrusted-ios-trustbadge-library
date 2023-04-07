//
//  Copyright (C) 2023 Trusted Shops AG
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
 TrustmarkDetailsModel contains details about a shop like
 name, url, target market, trustmark, etc
 */
class TrustmarkDetailsModel: Codable {
    let tsId: String
    let url: String
    let name: String
    let languageISO2: String
    let targetMarketISO3: String
    let trustMark: TrustmarkModel
}

/**
 TrustmarkModel contains details about a shop's trustmark like
 validity dates and status
 */
class TrustmarkModel: Codable {
    var status: TrustmarkStatus
    let validFrom: String
    let validTo: String

    // MARK: Public properties

    var isValid: Bool {
        self.status == .valid
    }
}

/**
 TrustmarkStatus enumeration indicates if a shop's trustmark is valid
 */
enum TrustmarkStatus: String, Codable {
    case valid = "VALID"
    case invalid = "INVALID"
}
