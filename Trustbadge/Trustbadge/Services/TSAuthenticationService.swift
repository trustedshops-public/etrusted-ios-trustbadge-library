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

    private var clientId: String?
    private var clientSecret: String?
    private var authenticationToken: AuthenticationTokenModel?

    // MARK: Initializer

    private init() {
        self.getClientDetailsFromConfigurationFile()
    }

    // MARK: Public methods

    /**
     This method calls TrustedShop's OAuth API for getting authentication toke with
     the given shop's `client id` and `client secret`
     */
    func getAuthenticationToken(responseHandler: @escaping ResponseHandler<Bool>) {
        guard let clientId = self.clientId,
              let clientSecret = self.clientSecret,
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

    // MARK: Private methods

    /**
     Client id and client secret are required values to authenticate client via the Trustedshop authentication API.
     This method loads these details from the local configuration plist file.
     */
    private func getClientDetailsFromConfigurationFile() {
        guard let path = Bundle.main.path(forResource: "TrustbadgeConfiguration", ofType: "plist"),
              let configuration = NSDictionary(contentsOfFile: path),
              let clientId = configuration[TrustbadgeConfigurationFileKeys.clientId] as? String,
              let clientSecret = configuration[TrustbadgeConfigurationFileKeys.clientSecret] as? String else {
            TSConsoleLogger.log(
                messege: "Error loading client id and secret from the configuration file",
                severity: .error
            )
            return
        }

        TSConsoleLogger.log(
            messege: "Successfully loaded client id and secret from the configuration file",
            severity: .info
        )
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}

/**
 TrustbadgeConfigurationFileKeys defines key names used in the trustbadge configuration plist file.
 These key names are used to collect values from the configuration plist file.
 */
struct TrustbadgeConfigurationFileKeys {
    static let clientId = "ClientId"
    static let clientSecret = "ClientSecret"
}
