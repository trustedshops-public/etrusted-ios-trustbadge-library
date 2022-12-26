//
//  TypeAliases.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 11/11/22.
//

import Foundation

typealias ResponseHandler<T> = (T) -> Void
typealias TSNetworkServiceResponseHandler<T: Codable> = ([T]?, TSNetworkServiceError?) -> Void
