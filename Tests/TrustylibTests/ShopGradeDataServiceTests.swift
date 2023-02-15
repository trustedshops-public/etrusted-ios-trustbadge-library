//
//  ShopGradeDataServiceTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 14/02/23.
//

import XCTest
@testable import Trustylib

final class ShopGradeDataServiceTests: XCTestCase {

    private let shopGradeDataService = ShopGradeDataService()
    private var didLoadShopGradeDetails = false

    override func setUpWithError() throws {
        self.didLoadShopGradeDetails = false
    }

    func testShopGradeServiceFailsWithoutTrustbadgeConfigurationAndAuthentication() throws {
        self.shopGradeDataService.getAggregateRatings(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { didLoadGrades in
            XCTAssertFalse(
                didLoadGrades,
                "ShopGradeDataService should fail without trustbadge configuration and successful client authentication"
            )
        }
    }

    func testShopGradeServiceReturnsGradeAfterTrustbadgeConfigurationAndAuthentication() {
        do {
            // Loading trustbadge configuration
            let bundle = Bundle(for: type(of: self))
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: bundle)

            // Authenticating client
            let accessTokenExpectation = expectation(description: "Client authentication returns valid access token")
            TSAuthenticationService.shared.getAuthenticationToken { _ in
                accessTokenExpectation.fulfill()
            }
            waitForExpectations(timeout: 3)

            // Fetching shop grade with ShopGradeDataService
            let shopGradeExpectation = expectation(description: "ShopGradeDataService response expectation")
            self.shopGradeDataService.getAggregateRatings(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { didLoadGrades in
                self.didLoadShopGradeDetails = didLoadGrades
                shopGradeExpectation.fulfill()
            }
            waitForExpectations(timeout: 5)
            XCTAssertNotNil(self.shopGradeDataService.shopAggregateRatings,
                            "ShopGradeDataService should return shop grade after successful trustbadge configuration and authentication")
        } catch {
            XCTFail("Failed to load shop grades due to missing trustbadge configuration")
        }
    }
}
