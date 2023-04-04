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
 getting shop grade details for the given channel id.
 */
class ShopGradeViewModel: ObservableObject {
        
    // MARK: Public properties
    
    @Published var shopGrade: String = ""
    @Published var shopRating: Float = 0
    @Published var shopRatingFormatted: String = ""
    
    /**
     Calls Trustedshops aggregate ratings API to get shop's grade details
     */
    func loadAggregateRating(for channelId: String, responseHandler: @escaping ResponseHandler<Bool>) {
        guard !channelId.isEmpty else {
            TSConsoleLogger.log(
                messege: "Error loading shop grade details due to invalid channel id",
                severity: .info
            )
            responseHandler(false)
            return
        }
        
        self.getAuthenticationTokenIfNeeded { [weak self] didGetToken in
            guard didGetToken else {
                responseHandler(false)
                return
            }
            
            let shopGradeDataService = ShopGradeDataService()
            shopGradeDataService.getAggregateRatings(for: channelId) { [weak self] ratings in
                guard let strongSelf = self,
                      let aggregateRatings = ratings else {
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
                
                strongSelf.shopGrade = aggregateRatings.oneYearRating.grade
                strongSelf.shopRating = aggregateRatings.oneYearRating.rating
                strongSelf.shopRatingFormatted = aggregateRatings.oneYearRating.ratingFormatted
                responseHandler(true)
            }
        }
    }

    /**
     Calls Trustedshops authentication service to obtain authentication token required for
     API calls that return details like shop grade, product grade, etc
     */
    func getAuthenticationTokenIfNeeded(responseHandler: @escaping ResponseHandler<Bool>) {
        guard TSAuthenticationService.shared.isAccessTokenExpired else {
            responseHandler(true)
            return
        }
        
        TSAuthenticationService.shared.getAuthenticationToken { didAuthenticate in
            guard didAuthenticate else {
                TSConsoleLogger.log(
                    messege: "Authentication error, failed to obtain authentication token",
                    severity: .error
                )
                responseHandler(false)
                return
            }

            TSConsoleLogger.log(
                messege: "Successfully recieved authentication token",
                severity: .info
            )
            responseHandler(true)
        }
    }
}
