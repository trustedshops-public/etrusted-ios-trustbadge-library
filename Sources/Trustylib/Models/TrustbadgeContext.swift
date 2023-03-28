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
//  Created by Prem Pratap Singh on 24/11/22.
//

import Foundation

/**
 TrustbadgeContext enumeration defines the context of the Trustbadge view.
 These context helps in setting the right UI appearance (shop grade, proudct grade, buyer protection, etc)
 and underlying behavior for the Trustbadge view
 */
@objc public enum TrustbadgeContext: Int {
    case trustMark
    case shopGrade
    case buyerProtection

    // MARK: Public properties

    /// Icon name for the context
    var iconImageName: String {
        switch self {
        case .trustMark: return "trustmarkIcon"
        case .shopGrade: return "shopGradeIcon"
        case .buyerProtection: return "buyerProtectionIcon"
        }
    }
}
