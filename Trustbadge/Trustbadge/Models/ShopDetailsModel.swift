//
//  ShopDetailsModel.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import Foundation

/**
 Data object for the response returned by the trustmark backend API
 */
class TrustmarkBackendResponseModel: Codable {
    let response: TrustmarkResponseModel
}

class TrustmarkResponseModel: Codable {
    let code: Int
    let data: TrustmarkResponseDataModel
    let message: String
    let status: String
}

class TrustmarkResponseDataModel: Codable {
    let shop: ShopDetailsModel
}

/**
 ShopDetailsModel contains details about a shop like
 name, url, target market, trustmark, etc
 */
class ShopDetailsModel: Codable {
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
    let status: String
    let validFrom: String
    let validTo: String
}
