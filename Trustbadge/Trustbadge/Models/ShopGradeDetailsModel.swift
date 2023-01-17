//
//  ShopGradeDetailsModel.swift
//  Trustbadge
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
