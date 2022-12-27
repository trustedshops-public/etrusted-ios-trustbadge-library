//
//  ShopGradeView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

struct ShopGradeView: View {

    // MARK: Public properties

    //var shopGradeDetails: ShopGradeDetailsModel
    var height: CGFloat
    var currentState: TrustbadgeState
    var isTrustmarkValid: Bool = false

    // MARK: User interface

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {

            // Shop Grade Text
            HStack(alignment: .center, spacing: 5) {
                Text(NSLocalizedString("Excellant",
                                       comment: "Trustbadge: Excellant grade title"))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .semibold))
                Text(NSLocalizedString("shops reviews",
                                       comment: "Trustbadge: Shop grade title"))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular))
            }

            // Star Rating View
            HStack(alignment: .center, spacing: 10) {
                StarRatingView(rating: 3.5)
                HStack(alignment: .center, spacing: 0) {
                    Text("3.5")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                    Text("/5.00")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                }
            }
        }
        .frame(width: self.currentState == .default(self.isTrustmarkValid) ? 0 : 200, height: self.height)
    }
}
