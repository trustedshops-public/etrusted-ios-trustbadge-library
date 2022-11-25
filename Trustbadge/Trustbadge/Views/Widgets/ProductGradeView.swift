//
//  ProductGradeView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

struct ProductGradeView: View {
    var height: CGFloat
    var currentState: TrustbadgeState
    
    var body: some View {
        Text(self.currentState == .expended ? "Product Grade" : "")
    }
}
