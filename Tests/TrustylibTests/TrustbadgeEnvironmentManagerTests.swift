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
//  Created by Prem Pratap Singh on 05/10/23.
//


import XCTest
@testable import Trustylib

/**
 TrustbadgeEnvironmentManagerTests tests the workflow for setting accurate Trustbadge environment 
 */
final class TrustbadgeEnvironmentManagerTests: XCTestCase {
    
    func testTrustbadgeEnvironmentManagerSetsProductionAsDefaultEnvironment() {
        XCTAssert(TrustbadgeEnvironmentManager.shared.currentEnvironment == .production, "TrustbadgeEnvironmentManager should set production as the deefault when info plist variable is not found")
    }
    
    func testTrustbadgeEnvironmentManagerSetsCorrectEnvironment() {
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "development")
        XCTAssert(TrustbadgeEnvironmentManager.shared.currentEnvironment == .development, "TrustbadgeEnvironmentManager should set correct environment for the given info plist value")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "stage")
        XCTAssert(TrustbadgeEnvironmentManager.shared.currentEnvironment == .stage, "TrustbadgeEnvironmentManager should set correct environment for the given info plist value")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "invalid")
        XCTAssert(TrustbadgeEnvironmentManager.shared.currentEnvironment == .production, "TrustbadgeEnvironmentManager should set environment to production for invalid info plist value")
        
        TrustbadgeEnvironmentManager.shared.testSetEnvironment(forValue: "production")
        XCTAssert(TrustbadgeEnvironmentManager.shared.currentEnvironment == .production, "TrustbadgeEnvironmentManager should set correct environment for the given info plist value")
    }
}
