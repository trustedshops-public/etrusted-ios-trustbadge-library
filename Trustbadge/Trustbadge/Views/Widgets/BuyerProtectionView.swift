//
//  BuyerProtectionView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

struct BuyerProtectionView: View {
    var height: CGFloat
    var currentState: TrustbadgeState

    var body: some View {
        Text(self.currentState == .expended ? "Buyer Protection" : "")
    }
}
