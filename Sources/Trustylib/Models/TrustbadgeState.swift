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
//  Created by Prem Pratap Singh on 24/11/22.
//

import Foundation


/**
 TrustbadgeState enumeration defines different possible UI states for the trustbadge view.
 These states are,
 1. `default` - In default state, the trustbadge view is presented as a circular badge icon aka `Seal`
 2. `expended` - In expended state, the trustbadge view shows a sub view expanding to show shop/product grade or other details
 3. `expendedAsPopup` - In this state, the trustbadge view is shown as a popup with a close button. This state helps in showing
 more details.
 4. `invisible` - In this state, the trustbadge view contents are hidden
 */
enum TrustbadgeState: Equatable {
    case `default`(Bool)
    case expended
    case expendedAsPopup
    case invisible

    // MARK: Public properties

    /// Icon name for the state
    var iconImageName: String {
        switch self {
        case .default(let isValid): return isValid ? "trustmarkIcon" : "trustmarkIconInvalidCertificate"
        case .expended: return ""
        case .expendedAsPopup: return "blueCrossIcon"
        case .invisible: return ""
        }
    }
}
