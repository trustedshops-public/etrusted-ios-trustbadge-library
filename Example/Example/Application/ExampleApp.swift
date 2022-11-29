//
//  ExampleApp.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI

@main
struct ExampleApp: App {
    @StateObject private var overlayContainerContext = OverlayContainerContext()
    @StateObject private var appContext = AppContext()

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(self.appContext)
                .environmentObject(self.overlayContainerContext)
        }
    }
}
