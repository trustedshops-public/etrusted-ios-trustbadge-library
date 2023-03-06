//
//  ShopGradeDataService.swift
//  Trustylib
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
