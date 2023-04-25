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
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
@testable import Trustylib

/**
 This test suite tests the `TrustbadgeViewModel` related workflows like initialization,
 state management and data load.
 */
final class TrustbadgeViewModelTests: XCTestCase {
    
    private let tsId = "X330A2E7D449E31E467D2F53A55DDD070"
    private let channelId = "chl-b309535d-baa0-40df-a977-0b375379a3cc"
    private let productId = "31303031"
    
    func testTrustbadgeViewModelInitializesWithCorrectContext() throws {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .shopGrade)
        XCTAssert(
            viewModel.activeContext == .shopGrade,
            "TrustbadgeViewModel context isn't set correctly during initialization"
        )
        
        let viewModel1 = TrustbadgeViewModel(tsId: self.tsId, context: .trustMark)
        XCTAssert(
            viewModel1.activeContext != .shopGrade,
            "TrustbadgeViewModel context isn't set correctly during initialization"
        )
    }
    
    func testTrustbadgeViewModelValidationSucceedsWithValidTrustmarkInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .trustMark)
        XCTAssert(
            viewModel.areBadgeInputsValid == true,
            "TrustbadgeViewModel validation should pass for valid trustmark context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationFailsWithoutValidTrustmarkInputs() {
        let viewModel = TrustbadgeViewModel(tsId: "", context: .trustMark)
        XCTAssert(
            viewModel.areBadgeInputsValid == false,
            "TrustbadgeViewModel validation should fail for invalid trustmark context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationSucceedsWithValidShopGradeInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, channelId: self.channelId, context: .shopGrade)
        XCTAssert(
            viewModel.areBadgeInputsValid == true,
            "TrustbadgeViewModel validation should pass for valid shop grade context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationFailsWithoutValidShopGradeInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .shopGrade)
        XCTAssert(
            viewModel.areBadgeInputsValid == false,
            "TrustbadgeViewModel validation should fail for invalid shop grade context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationSucceedsWithValidBuyerProtectionInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, channelId: self.channelId, context: .buyerProtection)
        XCTAssert(
            viewModel.areBadgeInputsValid == true,
            "TrustbadgeViewModel validation should pass for valid buyer protection context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationFailsWithoutValidBuyerProtectionInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .buyerProtection)
        XCTAssert(
            viewModel.areBadgeInputsValid == false,
            "TrustbadgeViewModel validation should fail for invalid buyer protection context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationSucceedsWithValidProductGradeInputs() {
        let viewModel = TrustbadgeViewModel(
            tsId: self.tsId,
            channelId: self.channelId,
            productId: self.productId,
            context: .buyerProtection)
        XCTAssert(
            viewModel.areBadgeInputsValid == true,
            "TrustbadgeViewModel validation should pass for valid product grade context parameters"
        )
    }
    
    func testTrustbadgeViewModelValidationFailsWithoutValidProductGradeInputs() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, channelId: self.channelId, context: .productGrade)
        XCTAssert(
            viewModel.areBadgeInputsValid == false,
            "TrustbadgeViewModel validation should fail for invalid product grade context parameters"
        )
    }
    
    func testTrustbadgeViewModelLoadsValidTrustMarkDetails() throws {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .shopGrade)
        let trustMarkDetailsExpectation = expectation(description: "TrustbadgeViewModel response expectation")
        
        viewModel.getTrustmarkDetails { _ in
            trustMarkDetailsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(
            viewModel.trustMarkDetails,
            "TrustbadgeViewModel should load trustmark details successfully for given TSID"
        )
    }
    
    func testTrustbadgeViewModelSetsCorrectIconNameForState() throws {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .trustMark)
        viewModel.setIconForState()
        
        XCTAssert(
            viewModel.iconImageName == "trustmarkIconInvalidCertificate",
            "TrustbadgeViewModel should set correct icon image name for the current badge state"
        )
        
        let trustMarkDetailsExpectation = expectation(description: "TrustbadgeViewModel response expectation")
        viewModel.getTrustmarkDetails { _ in
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
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .trustMark)
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
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .shopGrade)
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
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .shopGrade)
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
    
    func testTrustbadgeViewModelLoadsProductImageFromValidUrl() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .productGrade)
        let imageLoadExpectation = expectation(description: "Product load image expectation")
        var didLoadProductImage = false
        let imageUrl = "https://productimages.etrusted.com/products/prt-a8042e61-a28d-42cd-9cbe-8c7339ad12fa/1/original.jpg"
        viewModel.loadProductImageAndSetAsBadgeIcon(url: imageUrl) { didLoadImage in
            didLoadProductImage = didLoadImage
            imageLoadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertTrue(
            didLoadProductImage,
            "TrustbadgeViewModel should load product image from a valid image url"
        )
    }
    
    func testTrustbadgeViewModelDoesnotLoadProductImageFromEmptyUrl() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .productGrade)
        let imageLoadExpectation = expectation(description: "Product load image expectation")
        var didLoadProductImage = false
        viewModel.loadProductImageAndSetAsBadgeIcon(url: "") { didLoadImage in
            didLoadProductImage = didLoadImage
            imageLoadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertFalse(
            didLoadProductImage,
            "TrustbadgeViewModel should load product image from a valid image url"
        )
    }
    
    func testTrustbadgeViewModelDoesnotLoadProductImageFromInvalidUrl() {
        let viewModel = TrustbadgeViewModel(tsId: self.tsId, context: .productGrade)
        let imageLoadExpectation = expectation(description: "Product load image expectation")
        var didLoadProductImage = false
        viewModel.loadProductImageAndSetAsBadgeIcon(url: "www.unknown.com/iAmNotAnImage.png") { didLoadImage in
            didLoadProductImage = didLoadImage
            imageLoadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertFalse(
            didLoadProductImage,
            "TrustbadgeViewModel should load product image from a valid image url"
        )
    }
}
