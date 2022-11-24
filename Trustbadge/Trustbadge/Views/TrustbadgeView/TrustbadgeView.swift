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

    public init(tsid: String) {
        self.tsid = tsid
    }

    // MARK: Private properties
    private var tsid: String?
    @StateObject private var trustmarkDataService = TrustmarkDataService()

    // MARK: User interface

    public var body: some View {
        ZStack {
            if let trustMarkDetails = self.trustmarkDataService.trustMarkDetails {
                if trustMarkDetails.trustMark.isValid {
                    TrustbadgeImage(assetName: "iconTrustmark")
                        .onAppear {
                            TSConsoleLogger.log(
                                messege: "Trustmark for shop with tsid: \(self.tsid ?? "") is valid",
                                severity: .info
                            )
                            TSConsoleLogger.log(
                                messege: "Presented trustbadge successfully",
                                severity: .info
                            )
                        }
                }
            }
        }
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
        }
    }
}
