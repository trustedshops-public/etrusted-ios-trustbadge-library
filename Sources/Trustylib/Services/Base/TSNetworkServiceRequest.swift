//
//  TSNetworkServiceRequest.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 TSNetworkServiceRequest defines structure of a request object used for calling Trustedshops's backend API
 */
struct TSNetworkServiceRequest {

    // MARK: Public Properties

    var url: URL
    var method: String
    var parameters: [String: Any]?
    var body: Data?
    var headerValues: [String: String]?
    var contentType: String

    // MARK: Initializer

    init(
        url: URL,
        method: String,
        parameters: [String: Any]? = nil,
        body: Data? = nil,
        headerValues: [String: String]? = nil,
        contentType: String = TSNetworkServiceHeaderFieldValue.contentTypeJson) {

            self.url = url
            self.method = method
            self.parameters = parameters
            self.body = body
            self.headerValues = headerValues
            self.contentType = contentType
        }
}
