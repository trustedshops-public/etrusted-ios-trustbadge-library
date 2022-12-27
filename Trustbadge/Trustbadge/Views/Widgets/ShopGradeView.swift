//
//  ShopGradeView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

/**
 ShopGradeViewDelegate performs actions as delegated from the shop grade view.
 For example, when the shop grade details are loaded, the parent view is informed about the event
 so that the required actions be taken.
 */
protocol ShopGradeViewDelegate: Any {
    func didLoadShopGrades()
}

/**
 ShopGradeView calls Trustedshops backend API to load shop grade details and
 on load, it then shows the shop grade details with graphics and animated effects.
 */
struct ShopGradeView: View {

    // MARK: Public properties

    var channelId: String
    var currentState: TrustbadgeState
    var isTrustmarkValid: Bool = false
    var height: CGFloat
    var delegate: ShopGradeViewDelegate?

    // MARK: Private properties

    @StateObject private var shopGradeDataService = ShopGradeDataService()

    // MARK: User interface

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let aggregateRating = self.shopGradeDataService.shopAggregateRatings {
                // Shop Grade Text
                HStack(alignment: .center, spacing: 5) {
                    Text("\(aggregateRating.overallRating.grade)")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                    Text(NSLocalizedString("shops reviews",
                                           comment: "Trustbadge: Shop grade title"))
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                }

                // Star Rating View
                HStack(alignment: .center, spacing: 10) {
                    StarRatingView(rating: aggregateRating.overallRating.rating)
                    HStack(alignment: .center, spacing: 0) {
                        Text("\(aggregateRating.overallRating.rating.formatted())")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .semibold))
                        Text("/5.00")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                    }
                }
            }
        }
        .frame(width: self.currentState == .default(self.isTrustmarkValid) ? 0 : 200, height: self.height)
        .onAppear {
            self.loadAggregateRating()
        }
    }

    // MARK: Private methods

    /**
     Calls Trustedshops aggregate ratings API to get shop's grade details
     */
    private func loadAggregateRating() {
        guard !self.channelId.isEmpty else { return }
        self.getAuthenticationTokenIfNeeded { didGetToken in
            guard didGetToken else { return }
            self.shopGradeDataService.getAggregateRatings(for: self.channelId) { didGetRatings in
                guard didGetRatings else {
                    TSConsoleLogger.log(
                        messege: "Error loading shop grade details",
                        severity: .info
                    )
                    return
                }
                TSConsoleLogger.log(
                    messege: "Successfully loaded shop grade details",
                    severity: .info
                )
                self.delegate?.didLoadShopGrades()
            }
        }
    }
    /**
     Calls Trustedshops authentication service to obtain authentication token required for
     API calls that return details like shop grade, product grade, etc
     */
    private func getAuthenticationTokenIfNeeded(responseHandler: @escaping ResponseHandler<Bool>) {
        guard TSAuthenticationService.shared.isAccessTokenExpired else {
            responseHandler(true)
            return
        }
        TSAuthenticationService.shared.getAuthenticationToken { didAuthenticate in
            guard didAuthenticate else {
                TSConsoleLogger.log(
                    messege: "Authentication error, failed to obtain authentication token",
                    severity: .error
                )
                responseHandler(false)
                return
            }

            TSConsoleLogger.log(
                messege: "Successfully recieved authentication token",
                severity: .info
            )
            responseHandler(true)
        }
    }
}
