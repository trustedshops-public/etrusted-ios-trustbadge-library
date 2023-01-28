//
//  TSLogSeverity.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 08/11/22.
//

import Foundation

/**
 TsLogSeverity enumeration defines different level of severity for log messeges
 1. Info - Generic information like successful loading of the module, initialization, etc.
 2. Warning - Warning messages points to possibility of errors and nice to have changes.
 3. Error - Error messages show actual error details like runtime errors.
 */
public enum TSLogSeverity {
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
