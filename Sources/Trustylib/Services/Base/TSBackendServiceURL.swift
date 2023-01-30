//
//  TSBackendServiceURL.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/// TSBackendServiceURL configures application run environment and provides API for getting environment specific
/// details like backend service endpoints, etc
class TSBackendServiceURL {

    // MARK: Public properties

    static var shared: TSBackendServiceURL {
        guard let instance = self.instance else {
            let service = TSBackendServiceURL()
            self.instance = service
            return service
        }
        return instance
    }

    /*
     Returns TrustedShop's authentication service url
     */
    var authenticationServiceUrl: URL? {
        let endpoint = TSBackendServiceEndpoint.shopAuthentication.name
        let qualifiedURLString = self.authenticationServiceBaseUrlString.appending(endpoint)
        return URL(string: qualifiedURLString)
    }

    // MARK: Private properties

    private static var instance: TSBackendServiceURL?
    private var environment: TSEnvironmentKey = .prod
    private let buildEnvKey = "com.etrusted.ios.trustylib.ENDPOINTS"
    private let buildEnvValueStage = "STAGE"
    private let buildEnvValueProd = "PROD"

    /// Returns base URL string for TrustedShop's authentication services
    private var authenticationServiceBaseUrlString: String {
        switch self.environment {
        case .stage: return "https://login.etrusted.com"
        case .prod: return "https://login.etrusted.com"
        }
    }

    /// Returns base URL string for Trustedshop's backend services
    private var trustedShopsServiceBaseUrlString: String {
        switch self.environment {
        case .stage: return "https://api.etrusted.com"
        case .prod: return "https://api.etrusted.com"
        }
    }

    /// Returns base URL string for Trustedshop's CDN services
    private var cdnServiceBaseUrlString: String {
        switch self.environment {
        case .stage: return "https://cdn1.api-qa.trustedshops.com"
        case .prod: return "https://cdn1.api.trustedshops.com"
        }
    }

    // MARK: Initilizer

    private init() {
        self.configureEnvironment()
    }

    // MARK: Public methods

    /*
     Returns trustmark service url for the given tsid
     */
    func getTrustmarkServiceUrl(for tsid: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.trustmark.name
        let endpointWithTsid = String(format: endpoint, arguments: [tsid])
        return self.getQualifiedURL(for: endpointWithTsid, baseURLString: self.cdnServiceBaseUrlString)
    }

    /*
     Returns aggregate ratings service url for the given shop id
     */
    func getAggregateRatingServiceUrl(for shopId: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.aggregateRating.name
        let endpointWithShopId = String(format: endpoint, arguments: [shopId])
        return self.getQualifiedURL(for: endpointWithShopId, baseURLString: self.trustedShopsServiceBaseUrlString)
    }

    // MARK: Private methods

    /// Sets application run environment based on the launch key parameter
    /// Environment value determines the backend service endpoint URLs and other run environment specific details
    private func configureEnvironment() {
        guard let launchEnvKey = ProcessInfo.processInfo.environment[self.buildEnvKey] else {
            self.environment = .stage
            return
        }

        switch launchEnvKey {
        case buildEnvValueStage: self.environment = .stage
        case buildEnvValueProd: self.environment = .prod
        default: self.environment = .stage
        }
    }

    /// Returns qualified URL for the given endpoint and base URL string
    private func getQualifiedURL(for endpoint: TSBackendServiceEndpoint, baseURLString: String) -> URL? {
        let qualifiedURLString = baseURLString.appending(endpoint.name)
        let qualifiedURL = URL(string: qualifiedURLString)
        return qualifiedURL
    }

    private func getQualifiedURL(for endpoint: String, baseURLString: String) -> URL? {
        let qualifiedURLString = baseURLString.appending(endpoint)
        let qualifiedURL = URL(string: qualifiedURLString)
        return qualifiedURL
    }
}

/**
 TSEnvironmentKey enumeration defines build time environment for the library
 */
enum TSEnvironmentKey {
    case stage
    case prod
}

/**
 TSBackendServiceEndpoint defines Trustedshops backend API endpoints
 */
enum TSBackendServiceEndpoint: String {

    // Authentication endpoints
    case shopAuthentication = "/oauth/token"

    // Trustbadge endpoint
    case trustmark = "/shops/%@/mobiles/v1/sdks/ios/trustmarks.json"

    // Shop grade endpoint
    case shopGrade = "/shops/%@/mobiles/v1/sdks/ios/quality/reviews.json"

    // Shop aggregate rating endpoint
    case aggregateRating = "/channels/%@/service-reviews/aggregate-rating"

    // Product grade endpoint
    case productGrade = "/shops/%@/products/skus/%@/mobiles/v1/sdks/ios/quality/reviews.json"

    // Product review endpoint
    case productReviews = "/shops/%@/products/skus/%@/mobiles/v1/sdks/ios/reviews.json"

    // Returns string typed name of the endpoint
    var name: String {
        return self.rawValue
    }
}
