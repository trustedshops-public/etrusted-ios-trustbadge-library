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
 ShopGradeDataService connects to the Trustedshop's backend API for getting grade and rating details for the shop
 with given `tsid`. Based on the backend API response, it then responds back via `BoolResponseHandler`,
 indicating if the shop grade and rating details could successfully be loaded or failed due to some error.
 */
class ShopGradeDataService: TSNetworkDataService {

    // MARK: Public methods

    /**
     Calls Trustedshop's backend API for getting shop grade and rating details for the given `tsid`,
     handles response/error as returned by the backend and then responds back via response handler callback
     */
    func getAggregateRatings(for shopId: String, responseHandler: @escaping ResponseHandler<ShopAggregateRatingsModel?>) {
        guard let url = self.backendServiceURL.getAggregateRatingServiceUrl(for: shopId),
              let accessToken = TSAuthenticationService.shared.accessToken,
              var headerFields = self.headerFields else {
            responseHandler(nil)
            return
        }

        let authorizationValue = String(format: TSNetworkServiceHeaderFieldValue.authorizationBearerToken,
                                        arguments: [accessToken])
        headerFields[TSNetworkServiceHeaderField.authorization] = authorizationValue

        let networkRequest = TSNetworkServiceRequest(
            url: url,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: headerFields)

        let apiResponseHandler: TSNetworkServiceResponseHandler<ShopAggregateRatingsModel> = { response, error in
            guard let backendResponse = response,
                  let aggregateRatings = backendResponse.first,
                  error == nil else {
                responseHandler(nil)
                return
            }

            DispatchQueue.main.async {
                responseHandler(aggregateRatings)
            }
        }

        let responseConfiguration = TSNetworkServiceResponseConfiguration(
            hasResponseData: true,
            expectedResponseCode: .expected(200),
            unexpectedResponseCode: .unexpected(400),
            errorResponseCode: .error(500)
        )

        let _ = self.getData(
            request: networkRequest,
            responseConfiguration: responseConfiguration,
            responseHandler: apiResponseHandler
        )
    }
}

/**
 Data object for the response returned by the shop grade and rating backend API
 */
class ShopGradeBackendResponseModel: Codable {
    let response: ShopGradeResponseModel
}

class ShopGradeResponseModel: Codable {
    let code: Int
    let data: ShopGradeResponseDataModel
    let message: String
    let status: String
}

class ShopGradeResponseDataModel: Codable {
    let shop: ShopGradeDetailsModel
}
