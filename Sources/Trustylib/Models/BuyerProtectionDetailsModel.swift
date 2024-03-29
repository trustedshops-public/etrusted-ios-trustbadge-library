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
//  Created by Prem Pratap Singh on 28/03/23.
//

import Foundation

/**
 BuyerProtectionDetailsModel contains details about a shop's id, name and
 buyer protection (guarantee) support
 */
class BuyerProtectionDetailsModel: Codable {
    let tsId: String
    let name: String
    let guarantee: BuyerProtectionDetails
}

/**
 BuyerProtectionDetails contains details about a shop's
 buyer protection support like protection amount, currency and duration for coverage.
 */
class BuyerProtectionDetails: Codable {
    let mainProtectionCurrency: String
    let maxProtectionAmount: String
    let maxProtectionDuration: String
    
    /// Returns protection currency enum
    var protectionCurrency: CurrencyCode {
        let currency = CurrencyCode(rawValue: self.mainProtectionCurrency.lowercased()) ?? .eur
        return currency
    }
    
    /// Returns buyer protection amount rounded to 2 decimal points
    var protectionAmountFormatted: String {
        guard let protectionAmount = Double(self.maxProtectionAmount) else { return self.maxProtectionAmount }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = self.protectionCurrency.code
        formatter.currencySymbol = self.protectionCurrency.symbol
        formatter.maximumFractionDigits = 0

        let number = NSNumber(value: protectionAmount)
        return formatter.string(from: number)!
    }
}
