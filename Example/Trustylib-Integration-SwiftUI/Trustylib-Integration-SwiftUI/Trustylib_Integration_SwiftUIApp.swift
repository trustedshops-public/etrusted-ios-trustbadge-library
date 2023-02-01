//
//  Trustylib_Integration_SwiftUIApp.swift
//  Trustylib-Integration-SwiftUI
//
//  Created by Prem Pratap Singh on 01/02/23.
//

import SwiftUI
import Trustylib

@main
struct Trustylib_Integration_SwiftUIApp: App {

    init() {
        Trustbadge.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
