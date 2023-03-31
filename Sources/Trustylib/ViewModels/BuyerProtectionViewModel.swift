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
 BuyerProtectionViewModel serves BuyerProtectionView for managing it's states and
 getting buyer protection details for the given shop.
 */
class BuyerProtectionViewModel: ObservableObject {
    
    // MARK: Public properties
    
    @Published var protectionAmountFormatted: String = ""
    
    /**
     Calls Trustedshops buyer protection details API to get details for a given shop
     */
    func loadBuyerProtectionDetails(for tsid: String, responseHandler: @escaping ResponseHandler<Bool>) {
        let buyerProtectionDataService = BuyerProtectionDataService()
        buyerProtectionDataService.getBuyerProtectionDetails(for: tsid) { [weak self] details in
            guard let strongSelf = self,
                  let buyerProtectionDetails = details else {
                TSConsoleLogger.log(
                    messege: "Error loading buyer protection details for shop with tsid: \(tsid)",
                    severity: .error
                )
                responseHandler(false)
                return
            }
            
            TSConsoleLogger.log(
                messege: "Successfully loaded buyer protection details for shop with tsid: \(tsid)",
                severity: .info
            )
            strongSelf.protectionAmountFormatted = buyerProtectionDetails.guarantee.protectionAmountFormatted
            responseHandler(true)
        }
    }
}
