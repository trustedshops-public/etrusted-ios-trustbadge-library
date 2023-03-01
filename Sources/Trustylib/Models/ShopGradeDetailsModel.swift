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
//  Created by Prem Pratap Singh on 24/11/22.
//

import Foundation

/**
 ShopGradeDetailsModel contains details about a shop like
 name, url, target market, trustmark, grade, rating, etc
 */
class ShopGradeDetailsModel: Codable {
    let tsId: String
    let url: String
    let name: String
    let languageISO2: String
    let targetMarketISO3: String
    let qualityIndicators: QualityIndicatorsModel
}

class QualityIndicatorsModel: Codable {
    let reviewIndicator: ReviewIndicatorModel
}

class ReviewIndicatorModel: Codable {
    let activePeriodInDays: Int
    let activeReviewCount: Int
    let reviewsCountedSince: String
    let totalReviewCount: Int
    let overallMark: Double
    let overallMarkDescription: String?
    let reviewIndicatorPeriodSummary: ReviewIndicatorPeriodSummaryModel
}

class ReviewIndicatorPeriodSummaryModel: Codable {
    let reviewIndicatorPeriods: [ReviewIndicatorPeriodDetailsModel]
}

class ReviewIndicatorPeriodDetailsModel: Codable {
    let startDate: String
    let endDate: String
    let periodReviewCount: Int
    let activeReviewCount: Int
    let overallMark: Double
    let overallMarkDescription: String?
    let reviewIndicatorCriteria: [ReviewIndicatorCriteriaModel]
    let reviewIndicatorMarkSummaries: [ReviewIndicatorMarkSummariesModel]

}

class ReviewIndicatorCriteriaModel: Codable {
    let criterionDescription: String
    let periodCriterionCount: Int
    let mark: Double
    let markDescription: String?
}

class ReviewIndicatorMarkSummariesModel: Codable {
    let markDescription: String
    let periodMarkCount: Int
}
