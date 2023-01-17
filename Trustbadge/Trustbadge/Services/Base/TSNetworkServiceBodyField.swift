//
//  TSNetworkServiceBodyField.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 09/12/22.
//

import Foundation

struct TSNetworkServiceBodyField {
    static let grantType = "grant_type"
    static let clientId = "client_id"
    static let clientSecret = "client_secret"
    static let audience = "https://api.etrusted.com"
}

struct TSNetworkServiceBodyFieldValue {
    static let clientCredentials = "client_credentials"
    static let trustedShopBackendApiUrl = "https://api.etrusted.com"
}
