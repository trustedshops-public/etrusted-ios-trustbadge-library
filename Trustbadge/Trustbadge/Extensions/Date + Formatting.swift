//
//  Date + Formatting.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 08/11/22.
//

import Foundation

/**
 Defines utility methods for converting date object into formatted string
 */
internal extension Date {

    /**
     Returns string version of the date object respresented as `Year-Month-Date`
     */
    func toStringWithYearMonthAndDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    /**
     Returns string version of the date object respresented as `Hour:Minute:Seconds`
     */
    func toStringWithHourMinuteAndSecond() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
