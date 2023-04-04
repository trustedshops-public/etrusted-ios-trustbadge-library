//
//  Copyright (C) 2023 Trusted Shops AG
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
        TrustbadgeConfigurationService.shared.resetConfiguration()
        TSAuthenticationService.shared.resetAuthenticationToken()
    }

    func testShopGradeServiceFailsWithoutTrustbadgeConfigurationAndAuthentication() throws {
        self.shopGradeDataService.getAggregateRatings(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { aggregateRatings in
            XCTAssertNil(
                aggregateRatings,
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
            self.shopGradeDataService.getAggregateRatings(for: "chl-b309535d-baa0-40df-a977-0b375379a3cc") { ratings in
                self.didLoadShopGradeDetails = ratings != nil
                shopGradeExpectation.fulfill()
            }
            waitForExpectations(timeout: 5)
            XCTAssertTrue(self.didLoadShopGradeDetails,
                            "ShopGradeDataService should return shop grade after successful trustbadge configuration and authentication")
        } catch {
            XCTFail("Failed to load shop grades due to missing trustbadge configuration")
        }
    }
}
