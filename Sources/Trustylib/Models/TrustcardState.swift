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
//  Created by Prem Pratap Singh on 05/09/23.
//


import Foundation

/**
 TrustcardState defines the context of trustcard being presented. These states define the UI/UX and underlining
 business logic for the trustcard.
 
 Here is what these states refer to,
 1. `classicProtection` - This state refers to the use case when the consumer who placed the order, doesn't have buyer protection subscription.
 2. `plusProtection` - This state refers to the use case when the consumer has plus protection subscription.
 3. `protectionConfirmation` - This state is set after the consumer's opt in for buyer protection is successful. This state presents the subscription
 confirmation.
 4. `upgradeToPlusProtection` - This state presents the UI/UX for consumers to upgrade to plus protection subscription.
 5. `reviewInvitationForm` - This state presents the input form where the consumer needs to provide his/her email and order number so that
 review invitation could be sent to the consumer.
 */
@objc public enum TrustcardState: Int {
    case classicProtection
    case plusProtection
    case protectionConfirmation
    case upgradeToPlusProtection
    case reviewInvitationForm
    
    // MARK: - Public properties
    
    var title: String {
        switch self {
        case .classicProtection:
            return NSLocalizedString(
                "Protect your purchase!",
                comment: "Trustcard view - classic protection title"
            )
        case .protectionConfirmation:
            return NSLocalizedString(
                "Your purchase is protected up to %@!",
                comment: "Trustcard view - protection confirmation title"
            )
        default: return ""
        }
    }
}
