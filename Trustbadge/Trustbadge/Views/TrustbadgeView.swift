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

    // MARK: Public properties

    /// This boolean property controls the visibility of the trustbadge view
    public var isHidden: Bool = false {
        willSet {
            self.currentState = newValue == true ? .invisible : .default(self.isTrustmarkValid)
        }
    }

    // MARK: Private properties
    
    @StateObject private var trustmarkDataService = TrustmarkDataService()
    @State private var currentState: TrustbadgeState = .default(false)
    @State private var isTrustmarkValid: Bool = false
    @State private var shouldShowExpendedStateContent: Bool = false
    @State private var iconName: String = TrustbadgeState.default(false).iconName

    private var tsid: String
    private var channelId: String
    private var alignment: TrustbadgeViewAlignment
    private var context: TrustbadgeContext

    private let badgeIconBackgroundHeight: CGFloat = 64
    private let badgeIconHeight: CGFloat = 48

    // MARK: Initializer

    public init(
        tsid: String,
        channelId: String,
        context: TrustbadgeContext,
        alignment: TrustbadgeViewAlignment = .leading) {
            self.tsid = tsid
            self.channelId = channelId
            self.context = context
            self.alignment = alignment
    }

    // MARK: User interface

    public var body: some View {
        HStack(alignment: .center) {

            // This spacer helps in keeping the trustmark icon and expanding view
            // aligned to the right
            if self.alignment == .trailing {
                Spacer()
            }

            if self.trustmarkDataService.trustMarkDetails != nil {
                ZStack(alignment: self.alignment == .leading ? .leading : .trailing) {

                    // Expendable view
                    ZStack(alignment: .center) {
                        // Background
                        RoundedRectangle(cornerRadius: self.badgeIconBackgroundHeight * 0.5)
                            .fill(Color.white)
                            .frame(
                                width: self.currentState == .default(self.isTrustmarkValid) ? self.badgeIconBackgroundHeight : UIScreen.main.bounds.width - 40,
                                height: self.badgeIconBackgroundHeight
                            )
                            .animation(.easeOut(duration: 0.3), value: self.currentState)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)

                        // Content - Shop grade, product grade, etc
                        ZStack {
                            if self.context == .shopGrade {
                                ShopGradeView(
                                    channelId: self.channelId,
                                    currentState: self.currentState,
                                    isTrustmarkValid: self.isTrustmarkValid,
                                    height: self.badgeIconBackgroundHeight,
                                    delegate: self
                                )
                            } else if self.context == .productGrade {
                                ProductGradeView(
                                    height: self.badgeIconBackgroundHeight,
                                    currentState: self.currentState,
                                    isTrustmarkValid: self.isTrustmarkValid
                                )

                            } else if self.context == .buyerProtection {
                                BuyerProtectionView(
                                    height: self.badgeIconBackgroundHeight,
                                    currentState: self.currentState,
                                    isTrustmarkValid: self.isTrustmarkValid
                                )
                            }
                        }
                        .opacity(self.shouldShowExpendedStateContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.2), value: self.shouldShowExpendedStateContent)
                    }

                    // Trustbadge Icon
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: self.badgeIconBackgroundHeight, height: self.badgeIconBackgroundHeight)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)

                        TrustbadgeImage(
                            assetName: self.iconName,
                            width: self.badgeIconHeight,
                            height: self.badgeIconHeight
                        )
                    }
                    .frame(width: self.badgeIconBackgroundHeight, height: self.badgeIconBackgroundHeight)
                }
            }

            // This spacer helps in keeping the trustmark icon and expanding view
            // aligned to the left
            if self.alignment == .leading {
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .opacity(self.isHidden ? 0 : 1)
        .animation(.easeIn(duration: 0.2), value: self.isHidden)
        .onAppear {
            self.getTrustmarkDetails()
        }
    }

    // MARK: Private methods

    /**
     Calls backend API to download trustbadge details for the given tsid
     */
    private func getTrustmarkDetails() {
        self.trustmarkDataService.getTrustmarkDetails(for: self.tsid) { didLoadDetails in
            guard didLoadDetails else {
                TSConsoleLogger.log(
                    messege: "Error loading trustmark details for shop with tsid: \(self.tsid)",
                    severity: .error
                )
                return
            }
            TSConsoleLogger.log(
                messege: "Successfully loaded trustmark details for shop with tsid: \(self.tsid)",
                severity: .info
            )

            let trustMarkDetails = self.trustmarkDataService.trustMarkDetails
            self.isTrustmarkValid = trustMarkDetails?.trustMark.isValid ?? false
            self.currentState = TrustbadgeState.default(isTrustmarkValid)

            let validityString = isTrustmarkValid ? "is valid": "isn't valid!"
            TSConsoleLogger.log(
                messege: "Trustmark for shop with tsid: \(self.tsid) \(validityString)",
                severity: .info
            )

            self.setIconForState()
        }
    }

    /**
     Animates trustbadge UI components to show a subtle experience
     It first animates the expended background view. When the background view animation is completed,
     it then sets the visibility flag on for the expended view content like shop grade, product grade, etc
     */
    private func expandBadgeToShowDetails() {
        guard self.context != .trustMark else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.shouldShowExpendedStateContent = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentState = .expended
            self.setIconForState()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.shouldShowExpendedStateContent = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                self.currentState = .default(self.isTrustmarkValid)
                self.setIconForState()
            }
        }
    }

    /**
     Sets icon name for the current state
     */
    private func setIconForState() {
        if self.currentState == .default(self.isTrustmarkValid) {
            self.iconName = self.currentState.iconName

        } else if self.currentState == .expended {
            self.iconName = self.context.iconName
        }
    }
}

// MARK: ShopGradeViewDelegate methods

extension TrustbadgeView: ShopGradeViewDelegate {
    func didLoadShopGrades() {
        self.expandBadgeToShowDetails()
    }
}
