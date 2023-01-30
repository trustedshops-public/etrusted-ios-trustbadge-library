//
//  TrustylibError.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 TrustylibError enumeration defines common error codes related to the libary workflows
 */
enum TrustylibError: Error {

    // MARK: Library configuration related error codes

    case configurationFileNotFound
    case clientIdNotFound
    case clientSecretNotFound
}
