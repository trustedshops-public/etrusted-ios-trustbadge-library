//
//  TrustbadgeError.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustbadgeError enumeration defines common error codes related to the libary workflows
 */
enum TrustbadgeError: Error {

    // MARK: Library configuration related error codes

    case configurationFileNotFound
    case clientIdNotFound
    case clientSecretNotFound
}
