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

    var currentEnvironment: TSEnvironment {
        return self.environment
    }
    
    // MARK: Private properties

    private static var instance: TSBackendServiceURL?
    private var environment: TSEnvironment = .production
    
    private let environmentVariablesKey = "LSEnvironment"
    private let environmentKey = "TrustbadgeEnvironment"
    private let buildEnvValueDevelopment = "development"
    private let buildEnvValueStage = "stage"
    private let buildEnvValueProduction = "production"

    /// Returns base URL string for Trustedshop's CDN services
    private var cdnServiceBaseUrlString: String {
        switch self.environment {
        case .development: return "https://cdn1.api-dev.trustedshops.com"
        case .stage: return "https://cdn1.api-qa.trustedshops.com"
        case .production: return "https://cdn1.api.trustedshops.com"
        }
    }
    
    /// Returns base URL string for Trustedshops grade and ratings feed API
    private var integrationServiceBaseUrlString: String {
        switch self.environment {
        case .development: return "https://integrations.etrusted.koeln"
        case .stage: return "https://integrations.etrusted.site"
        case .production: return "https://integrations.etrusted.com"
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
    func getTrustmarkDetailsServiceUrl(for tsid: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.trustmarkDetails.name
        let endpointWithTsid = String(format: endpoint, arguments: [tsid])
        return self.getQualifiedURL(for: endpointWithTsid, baseURLString: self.cdnServiceBaseUrlString)
    }

    /*
     Returns shop grade service url for the given shop id
     */
    func getShopGradeServiceUrl(for shopId: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.shopGrade.name
        let endpointWithShopId = String(format: endpoint, arguments: [shopId])
        return self.getQualifiedURL(for: endpointWithShopId, baseURLString: self.integrationServiceBaseUrlString)
    }
    
    /*
     Returns product grade service url for the given channel and product ids
     */
    func getProductGradeServiceUrl(for channelId: String, productId: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.productGrade.name
        let endpointWithIds = String(format: endpoint, arguments: [channelId, productId])
        return self.getQualifiedURL(for: endpointWithIds, baseURLString: self.integrationServiceBaseUrlString)
    }
    
    /*
     Returns product details service url for the given channel and product ids
     */
    func getProductDetailsServiceUrl(for channelId: String, productId: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.productDetails.name
        let endpointWithIds = String(format: endpoint, arguments: [channelId, productId])
        return self.getQualifiedURL(for: endpointWithIds, baseURLString: self.integrationServiceBaseUrlString)
    }
    
    /*
     Returns buyer protection service url for the given tsid
     */
    func getBuyerProtectionDetailsServiceUrl(for tsid: String) -> URL? {
        let endpoint = TSBackendServiceEndpoint.trustmarkDetails.name
        let endpointWithTsid = String(format: endpoint, arguments: [tsid])
        return self.getQualifiedURL(for: endpointWithTsid, baseURLString: self.cdnServiceBaseUrlString)
    }

    // MARK: Private methods

    /// Sets application run environment based on the launch key parameter
    /// Environment value determines the backend service endpoint URLs and other run environment specific details
    private func configureEnvironment() {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let trustbadgeEnvironment = infoDictionary[self.environmentKey] as? String else {
            self.environment = .production
            return
        }
        
        switch trustbadgeEnvironment {
        case self.buildEnvValueDevelopment: self.environment = .development
        case self.buildEnvValueProduction: self.environment = .production
        case self.buildEnvValueStage: self.environment = .stage
        default: self.environment = .production
        }
    }

    private func getQualifiedURL(for endpoint: String, baseURLString: String) -> URL? {
        let qualifiedURLString = baseURLString.appending(endpoint)
        let qualifiedURL = URL(string: qualifiedURLString)
        return qualifiedURL
    }
}

/**
 TSEnvironment enumeration defines build time environment for the library
 */
enum TSEnvironment {
    case development
    case stage
    case production
}

/**
 TSBackendServiceEndpoint defines Trustedshops backend API endpoints
 */
enum TSBackendServiceEndpoint: String {

    // Trustbadge endpoint
    case trustmarkDetails = "/shops/%@/mobiles/v1/sdks/ios/trustmarks.json"

    // Shop grade endpoint
    case shopGrade = "/feeds/grades/v1/channels/%@/touchpoints/all/feed.json"
    
    // Product grade endpoint
    case productGrade = "/feeds/grades/v1/channels/%@/products/sku/%@/feed.json"
    
    // Product details endpoint
    case productDetails = "/feeds/products/v1/channels/%@/sku/%@/feed.json"

    // Returns string typed name of the endpoint
    var name: String {
        return self.rawValue
    }
}
