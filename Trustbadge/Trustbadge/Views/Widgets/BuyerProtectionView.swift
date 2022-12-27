//
//  BuyerProtectionView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

struct BuyerProtectionView: View {

    // MARK: Public properties

    var height: CGFloat
    var currentState: TrustbadgeState
    var isTrustmarkValid: Bool = false

    // MARK: Private properties

    private var descriptionText: String {
        let string = NSLocalizedString("Your purchase is protected up to €%d",
                                       comment: "Trustbadge: Buyer protection description")
        let stringWithAmount = String(format: string, 2500)
        return stringWithAmount
    }

    // MARK: User interface

    var body: some View {
        if self.currentState == .expended {
            VStack(alignment: .leading, spacing: 5) {
                Text(NSLocalizedString("Independent guarantee",
                                       comment: "Trustbadge: Buyer protection title"))
                    .foregroundColor(.black)
                    .font(.system(size: 13, weight: .semibold))
                Text(self.descriptionText)
                    .foregroundColor(.black)
                    .font(.system(size: 13, weight: .regular))
            }
            .padding(.leading, self.height)
        }
    }
}
