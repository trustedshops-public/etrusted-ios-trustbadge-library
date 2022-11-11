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
            VStack(alignment: .center, spacing: 10) {
                Text("TrustbadgeView")
                    .font(.system(size: 18, weight: .semibold))
                Text("Tsid: \(self.tsid ?? "")")
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(.all, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.yellow)
            )
        }
        .onAppear {
            self.getTrustbadgeDetails()
        }
    }

    // MARK: Private methods

    /**
     Calls backend API to download trustbadge details for the given tsid
     */
    private func getTrustbadgeDetails() {
        guard let shopId = self.tsid else {
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
