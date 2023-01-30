//
//  ShopAggregateRatingsModel.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 27/12/22.
//

import Foundation

/**
 ShopAggregateRatingsModel contains rating details for a shop from
 different period of tme like 7 days, 30 days, 90 days, one year and overall.
 */
class ShopAggregateRatingsModel: Codable {
    let sevenDaysRating: AggregateRatingModel
    let thirtyDaysRating: AggregateRatingModel
    let nintyDaysRating: AggregateRatingModel
    let oneYearRating: AggregateRatingModel
    let overallRating: AggregateRatingModel

    enum CodingKeys: String, CodingKey {
        case sevenDaysRating = "7days"
        case thirtyDaysRating = "30days"
        case nintyDaysRating = "90days"
        case oneYearRating = "365days"
        case overallRating = "overall"
    }
}

class AggregateRatingModel: Codable {
    let count: Int
    let rating: Float

    // MARK: Public properties

    /// Returns grade text based on rating
    var grade: String {
        if self.rating >= 3 && self.rating < 4 {
            return NSLocalizedString("Good", comment: "Poor shop grade text")
        } else if self.rating >= 4 && self.rating <= 5 {
            return NSLocalizedString("Excellant", comment: "Poor shop grade text")
        }
        return NSLocalizedString("Poor", comment: "Poor shop grade text")
    }

    /// Returns rating value rounded to 2 decimal points
    var ratingFormatted: String {
        let string = String(format: "%.2f", self.rating)
        return string
    }
}
