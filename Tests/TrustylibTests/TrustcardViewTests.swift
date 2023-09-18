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
//  Created by Prem Pratap Singh on 15/09/23.
//


import XCTest
import SwiftUI
@testable import Trustylib

/**
 TrustcardViewTests tests the UI/UX and functional workflows for TrustcardView
 */
final class TrustcardViewTests: XCTestCase {

    // MARK: - Private properties
    
    private var trustmarkDetailsModel: TrustmarkDetailsModel?
    private var trustcardView: TrustcardView?
    
    var orderDetails: OrderDetailsModel?
    var bindedOrderDetails: Binding<OrderDetailsModel?> = .constant(nil)
    var trustcardState: TrustcardState?
    var bindedTrustcardState: Binding<TrustcardState?> = .constant(nil)

    // MARK: - Unit tests
    
    override func setUpWithError() throws {
        self.getModalObjectForTrustmarkDetailsServiceMockResponse()
        self.orderDetails = OrderDetailsModel(number: "123", amount: 789, currency: .eur, paymentType: "credit-card", estimatedDeliveryDate: "23-11-2023", buyerEmail: "abc@xyz.com")
        self.bindedOrderDetails = Binding(get: { self.orderDetails }, set: { self.orderDetails = $0 })
        self.trustcardState = .classicProtection
        self.bindedTrustcardState = Binding(get: { self.trustcardState }, set: { self.trustcardState = $0 })
        
        self.trustcardView = TrustcardView(
            trustMarkDetails: self.trustmarkDetailsModel,
            orderDetails: self.bindedOrderDetails ,
            protectionAmountWithCurrencyCode: "100 $",
            state: self.bindedTrustcardState,
            height: .constant(100),
            delegate: self
        )
    }

    override func tearDownWithError() throws {
        self.trustmarkDetailsModel = nil
        self.trustcardView = nil
    }
    
    func testTrustcardViewIntializesWithCorrectValues() throws {
        guard let trustcardView = self.trustcardView else {
            XCTFail("Trustcard view should be initialized with valid values")
            return
        }
        
        XCTAssertNotNil(
            trustcardView.trustMarkDetails,
            "TrustcardView should be initialized with correct trustmark details"
        )
        
        XCTAssertNotNil(
            trustcardView.orderDetails,
            "TrustcardView should be initialized with correct order details value"
        )
        
        XCTAssertTrue(
            trustcardView.protectionAmountWithCurrencyCode == "100 $",
            "TrustcardView should be initialized with correct buyer protection amount value"
        )
        
        XCTAssertTrue(
            trustcardView.state == .classicProtection,
            "TrustcardView should be initialized with correct state value"
        )
    }
    
    func testTrustcardViewBodyIsNotNil() throws {
        guard let trustcardView = self.trustcardView else {
            XCTFail("Trustcard view should be initialized with valid values")
            return
        }
        
        XCTAssertNotNil(
            trustcardView.body,
            "Trustcard view body shouldn't return nil value"
        )
    }
    
    func testTrustcardViewReturnsCorrectURLs() throws {
        XCTAssert(
            TrustcardView.urlForTermsConditionsAndPrivacyPolicy == "https://www.trustedshops.com/tsdocument/BUYER_AUTO_PROTECTION_TERMS_en.pdf",
            "Trustcard view should return correct URL for terms, conditions and privacy policy"
        )
        
        XCTAssert(
            TrustcardView.urlForImprintAndDataProtection == "https://www.trustedshops.co.uk/imprint/#user-privacy-policy",
            "Trustcard view should return correct URL for imprint and data protection terms"
        )
    }
    
    func testTrustcardViewResetsWhenTappedOnDismissButton() {
        guard let trustcardView = self.trustcardView else {
            XCTFail("Trustcard view should be initialized with valid values")
            return
        }
        trustcardView.tapOnDismissButton()
        XCTAssertTrue(
            trustcardView.orderDetails == nil,
            "Trustcard view should set current state to nil when user taps on the dismiss button"
        )
    }
    
    func testTrustcardViewChangesStateWhenTappedOnSubscribeToProtectionButton() {
        guard let trustcardView = self.trustcardView else {
            XCTFail("Trustcard view should be initialized with valid values")
            return
        }
        trustcardView.tapOnSubscribeToProtectionButton()
        XCTAssertTrue(
            trustcardView.state == .protectionConfirmation,
            "Trustcard view should set state when user taps on the subscribe to protection button"
        )
    }
}

extension TrustcardViewTests: TrustcardViewDelegate {
    func didTapOnDismissTrustcardButton() {}
}

// MARK: Helper methods

extension TrustcardViewTests {
    /**
     Calls `FileDataLoader` utility to load mock json data from local file and get `TrustmarkDetailsModel`
     object after encoding the json data
     */
    private func getModalObjectForTrustmarkDetailsServiceMockResponse() {
        TestDataLoadWorker.getMockTrustmarkDetails { details in
            self.trustmarkDetailsModel = details
        }
    }
}

