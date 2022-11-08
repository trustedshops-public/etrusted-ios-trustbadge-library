//
//  TSLogSeverity.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 08/11/22.
//

import Foundation

/**
 TsLogSeverity enumeration defines different level of severity for log messeges
 1. Info
 2. Warning
 3. Error
 */
internal enum TSLogSeverity {
    case info, warning, error

    // MARK: Public properties

    /**
     Returns label string for the severity
     */
    var label: String {
        switch self {
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
}
