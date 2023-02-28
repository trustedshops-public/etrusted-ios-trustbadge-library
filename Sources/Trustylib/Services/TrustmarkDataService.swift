//
//  TrustmarkDataService.swift
//  Trustylib
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
