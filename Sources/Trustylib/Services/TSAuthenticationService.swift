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

    /// Returns singleton instance of the TSAuthenticationService
    static let shared = TSAuthenticationService()

    /// Returns access token as recieved from TrustedShops authentication API
    var accessToken: String? {
        guard let token = self.authenticationToken else {
            return nil
        }
        return token.accessToken
    }

    /// Returns true if time elapased since latest successful authentication is greater than or equal to
    /// token exipration time
    var isAccessTokenExpired: Bool {
        guard let token = self.authenticationToken else {
            return true
        }
        return token.isTokenExpired
    }

    // MARK: Private properties
    private var authenticationToken: AuthenticationTokenModel?

    // MARK: Initializer

    private init() {}

    // MARK: Public methods

    /**
     This method calls TrustedShop's OAuth API for getting authentication toke with
     the given shop's `client id` and `client secret`
     */
    func getAuthenticationToken(responseHandler: @escaping ResponseHandler<Bool>) {
        guard let clientId = TrustbadgeConfigurationService.shared.clientId,
              let clientSecret = TrustbadgeConfigurationService.shared.clientSecret,
              let url = self.backendServiceURL.authenticationServiceUrl else {
                responseHandler(false)
                return
        }

        let requestBodyString = "\(TSNetworkServiceBodyField.grantType)=\(TSNetworkServiceBodyFieldValue.clientCredentials)&\(TSNetworkServiceBodyField.audience)=\(TSNetworkServiceBodyFieldValue.trustedShopBackendApiUrl)&\(TSNetworkServiceBodyField.clientId)=\(clientId)&\(TSNetworkServiceBodyField.clientSecret)=\(clientSecret)"

        guard let requestBodyData = requestBodyString.data(using: .utf8) else {
            responseHandler(false)
            return
        }

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
                  let authenticationToken = backendResponse.first,
                  error == nil else {
                responseHandler(false)
                return
            }
            self.authenticationToken = authenticationToken
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
    }

    /**
     Resets the authorization token to default values.
     This is used while running the tests which require to test service call failure without valid authentication token.
     */
    func resetAuthenticationToken() {
        self.authenticationToken = nil
    }
}
