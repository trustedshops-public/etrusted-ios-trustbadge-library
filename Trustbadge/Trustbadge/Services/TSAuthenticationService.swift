//
//  TSAuthenticationService.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 06/12/22.
//

import Foundation

/**
 TSAuthenticationService commuinicates with the TrustedShop's authentication APIs obtain
 authentication token. This authentication token is then to connect with the TrustedShop's
 secured backend APIs.
 */
class TSAuthenticationService: TSNetworkDataService, ObservableObject {

    // MARK: Public properties


    // MARK: Public methods

    /**
     This method calls TrustedShop's OAuth API for getting authentication toke with
     the given shop's `client id` and `client secret`
     */
    func getAuthenticationTokenFor(
        clientId: String,
        clientSecret: String,
        responseHandler: @escaping ResponseHandler<Bool>) {

            guard let url = self.backendServiceURL.authenticationServiceUrl else {
                responseHandler(false)
                return
            }

            let requestBodyString = "\(TSNetworkServiceBodyField.grantType)=\(TSNetworkServiceBodyFieldValue.clientCredentials)&\(TSNetworkServiceBodyField.audience)=\(TSNetworkServiceBodyFieldValue.trustedShopBackendApiUrl)&\(TSNetworkServiceBodyField.clientId)=\(clientId)&\(TSNetworkServiceBodyField.clientSecret)=\(clientSecret)"

            guard let requestBodyData = requestBodyString.data(using: .utf8) else {
                responseHandler(false)
                return
            }

            do {
                let networkRequest = TSNetworkServiceRequest(
                    url: url,
                    method: TSNetworkServiceMethod.post,
                    parameters: nil,
                    body: requestBodyData,
                    headerValues: nil,
                    contentType: TSNetworkServiceHeaderFieldValue.contentTypeUrlEncoded
                )

                let apiResponseHandler: TSNetworkServiceResponseHandler<AuthenticationTokenModel> = { response, error in
                    guard let backendResponse = response,
                          let authenticationResponse = backendResponse.first,
                          error == nil else {
                        responseHandler(false)
                        return
                    }
                    responseHandler(true)
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

            } catch {
                responseHandler(false)
                return
            }
    }
}
