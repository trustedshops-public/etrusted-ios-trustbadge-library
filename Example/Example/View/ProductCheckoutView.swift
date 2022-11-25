//
//  ProductCheckoutView.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI
import Trustbadge

struct ProductCheckoutView: View {
    var body: some View {
        VStack {
            Spacer()
            TrustbadgeView(tsid: "X330A2E7D449E31E467D2F53A55DDD070", context: .buyerProtection)
                .frame(height: 100)
                .padding(.leading, 16)
                .padding(.bottom, 50)
        }
    }
}
