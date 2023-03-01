//
//  TrustbadgeViewModelTests.swift
//  TrustylibTests
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
