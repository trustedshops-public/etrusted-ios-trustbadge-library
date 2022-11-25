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
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(self.overlayContainerContext)
        }
    }
}
