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
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation
import Combine

/**
 TrustmarkDataService connects to the Trustedshop's backend API for getting trustmark details for the shop
 with given `tsid`. Based on the backend API response, it then responds back via response handler callback,
 indicating if the trustmark details could successfully be loaded or failed due to some error.
 */
class TrustmarkDataService: TSNetworkDataService {
    
    // MARK: Public methods

    /**
     Calls Trustedshop's backend API for getting trustmark details for the given `tsid`, handles response/error
     as returned by the backend and then responds back with `BoolResponseHandler`
     */
    func getTrustmarkDetails(
        for tsid: String,
        responseHandler: @escaping ResponseHandler<TrustmarkDetailsModel?>) {
            
        guard let url = self.backendServiceURL.getTrustmarkServiceUrl(for: tsid) else {
            responseHandler(nil)
            return
        }

        let networkRequest = TSNetworkServiceRequest(
            url: url,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: nil)

        let apiResponseHandler: TSNetworkServiceResponseHandler<TrustmarkBackendResponseModel> = { response, error in
            guard let backendResponse = response,
                  let trustmarkResponse = backendResponse.first,
                  error == nil else {
                responseHandler(nil)
                return
            }

            DispatchQueue.main.async {
                responseHandler(trustmarkResponse.response.data.shop)
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
 Data object for the response returned by the trustmark backend API
 */
class TrustmarkBackendResponseModel: Codable {
    let response: TrustmarkResponseModel
}

class TrustmarkResponseModel: Codable {
    let code: Int
    let data: TrustmarkResponseDataModel
    let message: String
    let status: String
}

class TrustmarkResponseDataModel: Codable {
    let shop: TrustmarkDetailsModel
}
