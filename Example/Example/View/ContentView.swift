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
            Text("Trustbadge Example")
                .padding()
        }
        .onAppear {
            TSConsoleLogger.log(messege: "Hello from the example app", severity: .info)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
