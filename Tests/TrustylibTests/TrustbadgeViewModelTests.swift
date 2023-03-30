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
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests the `TrustbadgeViewModel` related workflows like initialization,
 state management and data load.
 */
final class TrustbadgeViewModelTests: XCTestCase {
    
    func testTrustbadgeViewModelInitializesWithCorrectContext() throws {
        let viewModel = TrustbadgeViewModel(context: .shopGrade)
        XCTAssert(
            viewModel.activeContext == .shopGrade,
            "TrustbadgeViewModel context isn't set correctly during initialization"
        )
        
        let viewModel1 = TrustbadgeViewModel(context: .trustMark)
        XCTAssert(
            viewModel1.activeContext != .shopGrade,
            "TrustbadgeViewModel context isn't set correctly during initialization"
        )
    }
    
    func testTrustbadgeViewModelLoadsValidTrustMarkDetails() throws {
        let viewModel = TrustbadgeViewModel(context: .shopGrade)
        let trustMarkDetailsExpectation = expectation(description: "TrustbadgeViewModel response expectation")
        
        viewModel.getTrustmarkDetails(for: "X330A2E7D449E31E467D2F53A55DDD070") { _ in
            trustMarkDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(
            viewModel.trustMarkDetails,
            "TrustbadgeViewModel should load trustmark details successfully for given TSID"
        )
    }
    
    func testTrustbadgeViewModelSetsCorrectIconNameForState() throws {
        let viewModel = TrustbadgeViewModel(context: .trustMark)
        viewModel.setIconForState()
        
        XCTAssert(
            viewModel.iconImageName == "trustmarkIconInvalidCertificate",
            "TrustbadgeViewModel should set correct icon image name for the current badge state"
        )
        
        let trustMarkDetailsExpectation = expectation(description: "TrustbadgeViewModel response expectation")
        viewModel.getTrustmarkDetails(for: "X330A2E7D449E31E467D2F53A55DDD070") { _ in
            trustMarkDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        let iconName = viewModel.isTrustmarkValid ? "trustmarkIcon": "trustmarkIconInvalidCertificate"
        XCTAssert(
            viewModel.iconImageName == iconName,
            "TrustbadgeViewModel should set correct icon image name for the current badge state"
        )
    }
    
    func testTrustbadgeViewModelDoesntSetExpendedStateForTrustmarkContext() throws {
        let viewModel = TrustbadgeViewModel(context: .trustMark)
        viewModel.expandBadgeToShowDetails()
        let trustMarkExpendedStateExpectation = expectation(description: "TrustbadgeViewModel expened state expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            trustMarkExpendedStateExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.currentState == .default(false),
            "TrustbadgeViewModel shouldn't set expended state for the trustmark context"
        )
    }
    
    func testTrustbadgeViewModelSetsCorrectExpendedStateForShopGradeContext() throws {
        let viewModel = TrustbadgeViewModel(context: .shopGrade)
        viewModel.expandBadgeToShowDetails()
        let trustMarkExpendedStateExpectation = expectation(description: "TrustbadgeViewModel expened state expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            trustMarkExpendedStateExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssert(
            viewModel.currentState == .expended,
            "TrustbadgeViewModel should set correct expended and default state for the shop grade context"
        )
    }
    
    func testTrustbadgeViewModelResetsToDefaultStateAfterExpendedState() throws {
        let viewModel = TrustbadgeViewModel(context: .shopGrade)
        viewModel.expandBadgeToShowDetails()
        let trustMarkDefaultStateExpectation = expectation(description: "TrustbadgeViewModel default state expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(
                viewModel.currentState == .expended,
                "TrustbadgeViewModel should set correct expended and default state for the shop grade context"
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                trustMarkDefaultStateExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 8)
        XCTAssert(
            viewModel.currentState == .default(false),
            "TrustbadgeViewModel should reset to the default state after the expended state"
        )
    }
}
