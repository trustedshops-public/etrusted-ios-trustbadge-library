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
//  Created by Prem Pratap Singh on 27/02/23.
//

import Foundation

/**
 ShopGradeViewModel serves ShopGradeView for managing view states and
 getting shop ratings/grade details for the given channel id.
 */
class ShopGradeViewModel: ObservableObject {
        
    // MARK: Public properties
    
    @Published var shopGrade: String = ""
    @Published var shopRating: Float = 0
    @Published var shopRatingFormatted: String = ""
    
    /**
     Calls Trustedshops API to get shop's rating and grade details
     */
    func loadShopGrade(for channelId: String, responseHandler: @escaping ResponseHandler<Bool>) {
        guard !channelId.isEmpty else {
            TSConsoleLogger.log(
                messege: "Error loading shop grade details due to invalid channel id",
                severity: .error
            )
            responseHandler(false)
            return
        }
        
        let shopGradeDataService = ShopGradeDataService()
        shopGradeDataService.getShopGrade(for: channelId) { [weak self] grade in
            guard let strongSelf = self,
                  let shopGrade = grade else {
                TSConsoleLogger.log(
                    messege: "Error loading shop grade details",
                    severity: .error
                )
                responseHandler(false)
                return
            }
            
            TSConsoleLogger.log(
                messege: "Successfully loaded shop grade details for channel \(channelId)",
                severity: .info
            )
            
            strongSelf.shopGrade = shopGrade.grades.oneYearRating.grade
            strongSelf.shopRating = shopGrade.grades.oneYearRating.rating
            strongSelf.shopRatingFormatted = shopGrade.grades.oneYearRating.ratingFormatted
            responseHandler(true)
        }
    }
}
