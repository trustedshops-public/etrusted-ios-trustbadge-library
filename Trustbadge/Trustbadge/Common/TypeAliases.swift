//
//  TypeAliases.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 11/11/22.
//

import Foundation

typealias VoidResponseHandler = () -> Void
typealias BoolResponseHandler = (Bool) -> Void
typealias IntResponseHandler = (Int?) -> Void
typealias StringResponseHandler = (String?) -> Void
typealias TSNetworkServiceResponseHandler<T: Codable> = ([T]?, TSNetworkServiceError?) -> Void
