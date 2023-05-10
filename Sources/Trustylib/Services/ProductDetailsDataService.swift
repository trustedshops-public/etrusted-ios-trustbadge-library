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
 ProductDetailsDataService connects to the Trustedshop's backend API for getting  product details (name, image, gtin, etc) and
 product grade details with given `channelId` and `productId`. Based on the backend API response, it then responds back via the
 responseHandler, indicating if the product grade and rating details could successfully be loaded or failed due to some error.
 */
class ProductDetailsDataService: TSNetworkDataService {

    // MARK: Public methods

    /**
     Calls Trustedshop's backend API for getting product  details (name, image, gtin, etc) for the given `channelId` and `productId`.
     It then handles API response/error and then responds back via response handler callback
     */
    func getProductDetails(
        for channelId: String,
        productId: String,
        responseHandler: @escaping ResponseHandler<ProductDetailsModel?>
    ) {
        guard let url = self.backendServiceURL.getProductDetailsServiceUrl(for: channelId, productId: productId) else {
            responseHandler(nil)
            return
        }

        let networkRequest = TSNetworkServiceRequest(
            url: url,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: nil)

        let apiResponseHandler: TSNetworkServiceResponseHandler<ProductDetailsModel> = { response, error in
            guard let backendResponse = response,
                  let productDetails = backendResponse.first,
                  error == nil else {
                responseHandler(nil)
                return
            }

            DispatchQueue.main.async {
                responseHandler(productDetails)
            }
        }

        let responseConfiguration = TSNetworkServiceResponseConfiguration(
            hasResponseData: true,
            expectedResponseCode: .expected(200),
            unexpectedResponseCode: .unexpected(404),
            errorResponseCode: .error(500)
        )

        let _ = self.getData(
            request: networkRequest,
            responseConfiguration: responseConfiguration,
            responseHandler: apiResponseHandler
        )
    }
    
    /**
     Calls Trustedshop's backend API for getting product grade and rating details for the given `channelId` and `productId`.
     It then handles API response/error and then responds back via response handler callback
     */
    func getProductGrade(
        for channelId: String,
        productId: String,
        responseHandler: @escaping ResponseHandler<ProductGradeModel?>
    ) {
        guard let url = self.backendServiceURL.getProductGradeServiceUrl(
            for: channelId,
            productId: productId
        ) else {
            responseHandler(nil)
            return
        }

        let networkRequest = TSNetworkServiceRequest(
            url: url,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: nil)

        let apiResponseHandler: TSNetworkServiceResponseHandler<ProductGradeModel> = { response, error in
            guard let backendResponse = response,
                  let productGrade = backendResponse.first,
                  error == nil else {
                responseHandler(nil)
                return
            }

            DispatchQueue.main.async {
                responseHandler(productGrade)
            }
        }

        let responseConfiguration = TSNetworkServiceResponseConfiguration(
            hasResponseData: true,
            expectedResponseCode: .expected(200),
            unexpectedResponseCode: .unexpected(404),
            errorResponseCode: .error(500)
        )

        let _ = self.getData(
            request: networkRequest,
            responseConfiguration: responseConfiguration,
            responseHandler: apiResponseHandler
        )
    }
}
