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
//  Created by Prem Pratap Singh on 17/09/23.
//


import XCTest
@testable import Trustylib

/**
 ClassicProtectionViewTests tests UI/UX and functional workflows for ClassicProtectionView
 */
final class ClassicProtectionViewTests: XCTestCase {

    // MARK: - Private properties
    
    private var trustmarkDetailsModel: TrustmarkDetailsModel?
    private var classicProtectionView: ClassicProtectionView?

    // MARK: - Unit tests
    
    override func setUpWithError() throws {
        self.getModalObjectForTrustmarkDetailsServiceMockResponse()
        let orderDetails = OrderDetailsModel(number: "123", amount: 789, currency: .eur, paymentType: "credit-card", estimatedDeliveryDate: "23-11-2023", buyerEmail: "abc@xyz.com")
        
        self.classicProtectionView = ClassicProtectionView(
            trustMarkDetails: trustmarkDetailsModel!,
            orderDetails: orderDetails,
            protectionAmountWithCurrencyCode: "100 $",
            delegate: self
        )
    }

    override func tearDownWithError() throws {
        self.trustmarkDetailsModel = nil
        self.classicProtectionView = nil
    }

    func testClassicProtectionViewIntializesWithCorrectValues() throws {
        XCTAssertNotNil(
            self.classicProtectionView?.trustMarkDetails,
            "ClassicProtectionView should be initialized with correct trustmark details"
        )
        
        XCTAssertNotNil(
            self.classicProtectionView?.orderDetails,
            "ClassicProtectionView should be initialized with correct order details value"
        )
        
        XCTAssertTrue(
            self.classicProtectionView?.protectionAmountWithCurrencyCode == "100 $",
            "ClassicProtectionView should be initialized with correct buyer protection amount value"
        )
    }
    
    func testClassicProtectionViewBodyIsNotNil() throws {
        XCTAssertNotNil(
            self.classicProtectionView?.body,
            "ClassicProtectionView body shouldn't return nil value"
        )
    }
    
    func testProtectionTermsViewBodyIsNotNil() throws {
        let protectionTermsView = ProtectionTermsView(term: "All benefits of the Trusted Shops services")
        XCTAssertNotNil(
            protectionTermsView.body,
            "ProtectionTermsView body shouldn't return nil value"
        )
    }
}

// MARK: ClassicProtectionViewDelegate methods

extension ClassicProtectionViewTests: ClassicProtectionViewDelegate {
    func didTapOnSubscribeToProtectionButton() {}
}

// MARK: Helper methods

extension ClassicProtectionViewTests {
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
