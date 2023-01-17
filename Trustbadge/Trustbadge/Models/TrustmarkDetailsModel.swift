//
//  ShopDetailsModel.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 TrustmarkDetailsModel contains details about a shop like
 name, url, target market, trustmark, etc
 */
class TrustmarkDetailsModel: Codable {
    let tsId: String
    let url: String
    let name: String
    let languageISO2: String
    let targetMarketISO3: String
    let trustMark: TrustmarkModel
}

/**
 TrustmarkModel contains details about a shop's trustmark like
 validity dates and status
 */
class TrustmarkModel: Codable {
    var status: TrustmarkStatus
    let validFrom: String
    let validTo: String

    // MARK: Public properties

    var isValid: Bool {
        self.status == .valid
    }
}

/**
 TrustmarkStatus enumeration indicates if a shop's trustmark is valid
 */
enum TrustmarkStatus: String, Codable {
    case valid = "VALID"
    case invalid = "INVALID"
}
