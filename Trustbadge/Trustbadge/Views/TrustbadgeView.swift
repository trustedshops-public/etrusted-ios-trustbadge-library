//
//  TrustbadgeView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 10/11/22.
//

import SwiftUI

/**
 TrustbadgeView shows trust badge image for the shop
 */
public struct TrustbadgeView: View {

    // MARK: Initializer

    public init(tsid: String, context: TrustbadgeContext) {
        self.tsid = tsid
        self.context = context
    }

    // MARK: Private properties
    @StateObject private var trustmarkDataService = TrustmarkDataService()
    @State private var currentState: TrustbadgeState = .default
    @State private var shouldShowExpendedStateContent: Bool = false
    @State private var iconName: String = TrustbadgeState.default.iconName

    private var tsid: String?
    private var context: TrustbadgeContext

    private let badgeIconBackgroundHeight: CGFloat = 64
    private let badgeIconHeight: CGFloat = 48

    // MARK: User interface

    public var body: some View {
        HStack(alignment: .center) {
            if let trustMarkDetails = self.trustmarkDataService.trustMarkDetails,
                trustMarkDetails.trustMark.isValid {
                ZStack(alignment: .leading) {
                    // Expendable view
                    ZStack(alignment: .center) {
                        // Background
                        RoundedRectangle(cornerRadius: self.badgeIconBackgroundHeight * 0.5)
                            .fill(Color.white)
                            .frame(
                                width: self.currentState == .default ? self.badgeIconBackgroundHeight : UIScreen.main.bounds.width - 50,
                                height: self.badgeIconBackgroundHeight
                            )
                            .animation(.easeOut(duration: 0.3))
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)

                        // Content - Shop grade, product grade, etc
                        ZStack {
                            if self.context == .shopGrade {
                                ShopGradeView(
                                    height: self.badgeIconBackgroundHeight,
                                    currentState: self.currentState
                                )
                            } else if self.context == .productGrade {
                                ProductGradeView(
                                    height: self.badgeIconBackgroundHeight,
                                    currentState: self.currentState
                                )

                            } else if self.context == .buyerProtection {
                                BuyerProtectionView(
                                    height: self.badgeIconBackgroundHeight,
                                    currentState: self.currentState
                                )
                            }
                        }
                        .opacity(self.shouldShowExpendedStateContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.2))
                    }

                    // Trustbadge Icon
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: self.badgeIconBackgroundHeight, height: self.badgeIconBackgroundHeight)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)
                        TrustbadgeImage(assetName: self.iconName)
                            .frame(width: self.badgeIconHeight, height: self.badgeIconHeight)
                            .animation(.easeIn(duration: 0.2))
                    }
                }
                Spacer()
            } else {
                // Icon showing invalid trustmark state
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .onAppear {
            self.getTrustmarkDetails()
        }
    }

    // MARK: Private methods

    /**
     Calls backend API to download trustbadge details for the given tsid
     */
    private func getTrustmarkDetails() {
        guard let shopId = self.tsid else {
            TSConsoleLogger.log(
                messege: "Error showing the trustbadge due to missing tsid",
                severity: .error
            )
            return
        }

        self.trustmarkDataService.getTrustmarkDetails(for: shopId) { didLoadDetails in
            guard didLoadDetails else { return }
            TSConsoleLogger.log(
                messege: "Successfully loaded trustmark details for shop with tsid: \(self.tsid ?? "")",
                severity: .info
            )

            let trustMarkDetails = self.trustmarkDataService.trustMarkDetails
            let isTrustmarkValid = trustMarkDetails?.trustMark.isValid ?? false
            let validityString = isTrustmarkValid ? "is valid": "isn't valid!"
            TSConsoleLogger.log(
                messege: "Trustmark for shop with tsid: \(self.tsid ?? "") \(validityString)",
                severity: .info
            )

            self.showBadgeAnimationIfNeeded()
        }
    }

    /**
     Animates trustbadge UI components to show a subtle experience
     It first animates the expended background view. When the background view animation is completed,
     it then sets the visibility flag on for the expended view content like shop grade, product grade, etc
     */
    private func showBadgeAnimationIfNeeded() {
        guard self.context != .trustMark else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.shouldShowExpendedStateContent = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentState = .expended
            self.setIconForState()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.shouldShowExpendedStateContent = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                self.currentState = .default
                self.setIconForState()
            }
        }
    }

    /**
     Sets the icon name for the current state
     */
    private func setIconForState() {
        if self.currentState == .default {
            self.iconName = self.currentState.iconName

        } else if self.currentState == .expended {
            self.iconName = self.context.iconName
        }
    }
}
