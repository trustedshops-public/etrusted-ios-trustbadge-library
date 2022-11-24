//
//  TrustbadgeContext.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import Foundation

/**
 TrustbadgeContext enumeration defines the context of the Trustbadge view.
 These context helps in setting the right UI appearance (shop grade, proudct grade, trustmark, etc)
 and underlying behavior for the Trustbadge view
 */
public enum TrustbadgeContext {
    case trustMark
    case shopGrade
    case productGrade
    case buyerProtection
}
