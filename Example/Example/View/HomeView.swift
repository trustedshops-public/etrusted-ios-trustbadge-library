//
//  HomeView.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI
import Trustbadge

struct HomeView: View {

    var body: some View {
        VStack {
            Spacer()
            TrustbadgeView(tsid: "X330A2E7D449E31E467D2F53A55DDD070", context: .shopGrade)
                .frame(width: 100, height: 100)
                .padding(.leading, 16)
                .padding(.bottom, 50)
        }
    }
}
