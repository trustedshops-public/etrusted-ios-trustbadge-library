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
            TrustbadgeView(tsid: "X86BFB46EE0BBFC1EA5D0A858030D8B3A")
                .frame(width: 200, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
