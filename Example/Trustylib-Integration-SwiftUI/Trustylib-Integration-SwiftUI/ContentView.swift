//
//  ContentView.swift
//  Trustylib-Integration-SwiftUI
//
//  Created by Prem Pratap Singh on 01/02/23.
//

import SwiftUI
import Trustylib

struct ContentView: View {
    var body: some View {
        VStack {
            TrustbadgeView(
                tsid: "X330A2E7D449E31E467D2F53A55DDD070",
                channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
                context: .shopGrade
            )
            .frame(height: 75)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
