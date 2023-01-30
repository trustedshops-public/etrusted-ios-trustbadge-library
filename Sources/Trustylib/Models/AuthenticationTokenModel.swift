//
//  AuthenticationTokenModel.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 06/12/22.
//

import Foundation

/**
 AuthenticationTokenModel contains details about Trustedshops authentication token,
 exiry time, refresh time details, etc
 */
class AuthenticationTokenModel: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshExpiresIn: Int
    let tokenType: String
    let scope: String
    let latestAuthenticationTimestamp = Date()

    // MARK: Public properties
    var isTokenExpired: Bool {
        let now = Date()
        let timeElapsed = latestAuthenticationTimestamp.distance(to: now)
        return Int(timeElapsed) >= expiresIn
    }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
