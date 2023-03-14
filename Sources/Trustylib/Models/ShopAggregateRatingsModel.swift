//
//  Copyright (C) 2023 Trusted Shops GmbH
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
        if self.rating >= 4.5 {
            return NSLocalizedString("Excellent", comment: "Excellent shop grade text")
        } else if self.rating >= 3.5 && self.rating < 4.5 {
            return NSLocalizedString("Good", comment: "Good shop grade text")
        } else if self.rating >= 2.5 && self.rating < 3.5 {
            return NSLocalizedString("Fair", comment: "Fair shop grade text")
        } else if self.rating >= 1.5 && self.rating < 2.5 {
            return NSLocalizedString("Poor", comment: "Poor shop grade text")
        }

        // If rating is less than 1.5
        return NSLocalizedString("Very poor", comment: "Very poor shop grade text")
    }

    /// Returns rating value rounded to 2 decimal points
    var ratingFormatted: String {
        let string = String(format: "%.2f", self.rating)
        return string
    }
}
