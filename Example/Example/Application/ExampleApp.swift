//
//  ExampleApp.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI
import Trustylib

@main
struct ExampleApp: App {

    // MARK: Private properties

    @StateObject private var overlayContainerContext = OverlayContainerContext()
    @StateObject private var appContext = AppContext()
    @StateObject private var shoppingCart = ShoppingCart(checkoutItems: [])

    // MARK: Initializeer

    init() {
        Trustbadge.configure()
    }

    // MARK: User interface
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(self.appContext)
                .environmentObject(self.overlayContainerContext)
                .environmentObject(self.shoppingCart)
        }
    }
}
