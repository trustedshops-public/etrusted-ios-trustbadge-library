//
//  TSLogger.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 08/11/22.
//

import Foundation

/**
 TSLogger protocol defines the commong API to be used in
 different logger types
 */
internal protocol TSLogger {
    static func log(
        messege: String,
        severity: TSLogSeverity,
        file: String,
        method: String
    )
}
