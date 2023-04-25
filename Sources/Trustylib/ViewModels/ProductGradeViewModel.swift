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
//  Created by Prem Pratap Singh on 20/04/23.
//


import Foundation

/**
 ProductGradeViewModel serves ProductGradeView for managing view states and
 getting product grade details for the given channel id and product id.
 */
class ProductGradeViewModel: ObservableObject {
    
    // MARK: Public properties
    
    @Published var productGrade: String = ""
    @Published var productRating: Float = 0
    @Published var productImageUrl: String = ""
    @Published var productRatingFormatted: String = ""
    
    /**
     Calls Trustedshops API for loading product details
     */
    func loadProductDetails(
        for channelId: String,
        productId: String,
        responseHandler: @escaping ResponseHandler<Bool>) {
            
            guard !channelId.isEmpty, !productId.isEmpty else {
                TSConsoleLogger.log(
                    messege: "Error loading product details due to invalid channel id or product id",
                    severity: .error
                )
                responseHandler(false)
                return
            }
            
            let productDetailsDataService = ProductDetailsDataService()
            productDetailsDataService.getProductDetails(for: channelId, productId: productId) { [weak self] details in
                guard let strongSelf = self,
                      let productDetails = details else {
                    TSConsoleLogger.log(
                        messege: "Error loading product details for channel id \(channelId) and product id \(productId)",
                        severity: .error
                    )
                    responseHandler(false)
                    return
                }
                
                TSConsoleLogger.log(
                    messege: "Successfully loaded product details for channel id \(channelId) and product id \(productId)",
                    severity: .info
                )
                
                if let productImage = productDetails.image, let originalImage = productImage.original {
                    strongSelf.productImageUrl = originalImage.url
                }
                responseHandler(true)
            }
        
    }
    
    /**
     Calls Trustedshops product grade ratings API to get product grade details
     */
    func loadProductRating(
        for channelId: String,
        productId: String,
        responseHandler: @escaping ResponseHandler<Bool>) {
            
            guard !channelId.isEmpty, !productId.isEmpty else {
                TSConsoleLogger.log(
                    messege: "Error loading product grade details due to invalid channel id or product id",
                    severity: .error
                )
                responseHandler(false)
                return
            }
            
            let productDetailsDataService = ProductDetailsDataService()
            productDetailsDataService.getProductRatings(for: channelId, productId: productId) { [weak self] ratings in
                guard let strongSelf = self,
                      let productRatings = ratings else {
                    TSConsoleLogger.log(
                        messege: "Error loading product grade details for channel id \(channelId) and product id \(productId)",
                        severity: .error
                    )
                    responseHandler(false)
                    return
                }
                
                TSConsoleLogger.log(
                    messege: "Successfully loaded product grade details for channel id \(channelId) and product id \(productId)",
                    severity: .info
                )
                
                strongSelf.productGrade = productRatings.grades.oneYearRating.grade
                strongSelf.productRating = productRatings.grades.oneYearRating.rating
                strongSelf.productRatingFormatted = productRatings.grades.oneYearRating.ratingFormatted
                responseHandler(true)
            }
    }
}
