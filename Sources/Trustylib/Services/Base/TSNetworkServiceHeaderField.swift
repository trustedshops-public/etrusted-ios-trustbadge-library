//
//  TSNetworkServiceHeaderField.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 TSNetworkServiceHeaderField defines header field keys as expected by the Trustedshops
 backend services
 */
struct TSNetworkServiceHeaderField {
    static let authorization = "Authorization"
    static let accessToken = "Access-Token"
    static let contentType = "Content-Type"
    static let accept = "Accept"
}

/**
 TSNetworkServiceHeaderFieldValue defines values for header key as expected by the Trustedshops
 backend services
 */
struct TSNetworkServiceHeaderFieldValue {
    static let authorizationBearerToken = "Bearer %@"
    static let contentTypeJson = "application/json"
    static let contentTypeUrlEncoded = "application/x-www-form-urlencoded"
    static let acceptAll = "*/*"
}
