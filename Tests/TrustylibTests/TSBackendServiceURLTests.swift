//
//  Copyright (C) 2023 Trusted Shops GmbH
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
//  Created by Prem Pratap Singh on 20/05/23.
//


import XCTest
@testable import Trustylib

/**
 TSBackendServiceURLTests tests library API url related workflows like
 setting up of the current environment, accuracy of the API urls, etc.
 */
final class TSBackendServiceURLTests: XCTestCase {

    func testTSBackendServiceURLReturnsCorrectAPIUrl() {
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "development")
        let serviceURLDev = TSBackendServiceURL.shared.getShopGradeServiceUrl(for: "TestChannel")?.absoluteString
        XCTAssert(serviceURLDev == "https://integrations.etrusted.koeln/feeds/grades/v1/channels/TestChannel/touchpoints/all/feed.json", "TSBackendServiceURL should return correct API url for the given environment")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "stage")
        let serviceURLTest = TSBackendServiceURL.shared.getShopGradeServiceUrl(for: "TestChannel")?.absoluteString
        XCTAssert(serviceURLTest == "https://integrations.etrusted.site/feeds/grades/v1/channels/TestChannel/touchpoints/all/feed.json", "TSBackendServiceURL should return correct API url for the given environment")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "production")
        let serviceURLProd = TSBackendServiceURL.shared.getShopGradeServiceUrl(for: "TestChannel")?.absoluteString
        XCTAssert(serviceURLProd == "https://integrations.etrusted.com/feeds/grades/v1/channels/TestChannel/touchpoints/all/feed.json", "TSBackendServiceURL should return correct API url for the given environment")
    }
    
    func testTSBackendServiceURLReturnsCorrectCDNUrl() {
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "development")
        let serviceURLDev = TSBackendServiceURL.shared.getTrustmarkDetailsServiceUrl(for: "TestTSID")?.absoluteString
        XCTAssert(serviceURLDev == "https://cdn1.api-dev.trustedshops.com/shops/TestTSID/mobiles/v1/sdks/ios/trustmarks.json", "TSBackendServiceURL should return correct CDN url for the given environment")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "stage")
        let serviceURLTest = TSBackendServiceURL.shared.getTrustmarkDetailsServiceUrl(for: "TestTSID")?.absoluteString
        XCTAssert(serviceURLTest == "https://cdn1.api-qa.trustedshops.com/shops/TestTSID/mobiles/v1/sdks/ios/trustmarks.json", "TSBackendServiceURL should return correct CDN url for the given environment")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "production")
        let serviceURLProd = TSBackendServiceURL.shared.getTrustmarkDetailsServiceUrl(for: "TestTSID")?.absoluteString
        XCTAssert(serviceURLProd == "https://cdn1.api.trustedshops.com/shops/TestTSID/mobiles/v1/sdks/ios/trustmarks.json", "TSBackendServiceURL should return correct CDN url for the given environment")
    }
}
