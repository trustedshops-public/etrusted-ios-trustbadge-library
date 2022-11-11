//
//  ContentView.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI
import Trustbadge

struct ContentView: View {

    var body: some View {
        ZStack {
            TrustbadgeView(tsid: "X330A2E7D449E31E467D2F53A55DDD070")
                .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
