//
//  ShopGradeDataService.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import Foundation

/**
 ShopGradeDataService connects to the Trustedshop's backend API for getting grade and rating details for the shop
 with given `tsid`. Based on the backend API response, it then responds back via `BoolResponseHandler`,
 indicating if the shop grade and rating details could successfully be loaded or failed due to some error.
 */
class ShopGradeDataService: TSNetworkDataService, ObservableObject {

    // MARK: Public properties

    @Published var shopGradeDetails: ShopGradeDetailsModel?

    // MARK: Public methods

    /**
     Calls Trustedshop's backend API for getting shop grade and rating details for the given `tsid`,
     handles response/error as returned by the backend and then responds back with `BoolResponseHandler`
     */
    func getShopGradeDetails(for tsid: String, responseHandler: @escaping ResponseHandler<Bool>) {
        guard let url = self.backendServiceURL.getShopGradeServiceUrl(for: tsid) else {
            responseHandler(false)
            return
        }

        let networkRequest = TSNetworkServiceRequest(
            url: url,
            method: TSNetworkServiceMethod.get,
            parameters: nil,
            body: nil,
            headerValues: nil)

        let apiResponseHandler: TSNetworkServiceResponseHandler<ShopGradeBackendResponseModel> = { response, error in
            guard let backendResponse = response,
                  let trustmarkResponse = backendResponse.first,
                  error == nil else {
                print("Error loading trustmark details \(error?.type.description ?? "")")
                responseHandler(false)
                return
            }

            DispatchQueue.main.async {
                self.shopGradeDetails = trustmarkResponse.response.data.shop
                responseHandler(true)
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
