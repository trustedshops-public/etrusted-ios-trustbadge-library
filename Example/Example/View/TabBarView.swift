//
//  TabBarView.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI

/**
 TabBarView presents the main tab view of the application and provides tab based UI/UX
 to navigate across main views like home view, product list view, product details view, checkout view, etc
 */

import SwiftUI
import Combine

struct TabBarView: View {

    // MARK: Private properties

    @EnvironmentObject private var appContext: AppContext
    @State private var shouldShowOverlayContainerview: Bool = false

    // MARK: User interface
    var body: some View {
        ZStack {
            /// Main Tab View
            TabView(selection: self.$appContext.selectedMainTab) {
                HomeView()
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .tag(0)

                ProductsListView()
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .tag(1)

                ProductCheckoutView()
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .tag(2)

                UserProfileView()
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .tag(3)
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .clear
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().clipsToBounds = true
            }

            /// Footer banner image
            Image("tabBarFooterImage")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 1.25, height: 140)
                .position(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height - 40)

            /// Floating Tab Buttons Background
            RoundedRectangle(cornerRadius: 36)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 40, height: 72, alignment: .center)
                .position(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height - 80)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 3)

            /// Floating Tab Buttons
            HStack(spacing: 35) {
                B2CTabButton(selectedTab: self.$appContext.selectedMainTab,
                             iconName: "homeTabIcon",
                             iconSize: 24,
                             titleText: NSLocalizedString("Home",
                                                          comment: "Main tab view - home button title"),
                             tabIndex: 0)

                B2CTabButton(selectedTab: self.$appContext.selectedMainTab,
                             iconName: "productsTabIcon",
                             iconSize: 24,
                             titleText: NSLocalizedString("Products",
                                                          comment: "Main tab view - bookmark button title"),
                             tabIndex: 1)

                B2CTabButton(selectedTab: self.$appContext.selectedMainTab,
                             iconName: "checkoutTabIcon",
                             iconSize: 24,
                             titleText: NSLocalizedString("Checkout",
                                                          comment: "Main tab view - trustpoint button title"),
                             tabIndex: 2)

                B2CTabButton(selectedTab: self.$appContext.selectedMainTab,
                             iconName: "profileTabIcon",
                             iconSize: 24,
                             titleText: NSLocalizedString("Profile",
                                                          comment: "Main tab view - profile button title") ,
                             tabIndex: 3)
            }
            .frame(width: UIScreen.main.bounds.width - 80, height: 72, alignment: .center)
            .position(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height - 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

/// Custom view for B2CTabView bar buttons
struct B2CTabButton: View {

    // MARK: Public properties
    @Binding var selectedTab: Int
    var iconName: String
    var iconSize: CGFloat
    var titleText: String
    var tabIndex: Int

    // MARK: User interface
    var body: some View {
        Button(
            action: {
                self.selectedTab = self.tabIndex
            },
            label: {
                VStack(alignment: .center, spacing: 3) {
                    Image(self.iconName)
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(self.selectedTab == self.tabIndex ? .tsBlue700 : .tsGray600)
                        .frame(width: self.iconSize, height: self.iconSize)
                    Text(self.titleText)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(self.selectedTab == self.tabIndex ? .tsBlue700 : .tsGray600)
                }
            }
        )
    }
}
