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
@testable import Trustylib

/**
 OrderDetailsModelTests tests the initialization process and accuracy of OrderDetailsModel properties
 */
final class OrderDetailsModelTests: XCTestCase {

    func testOrderDetailsModelInitializesWithCorrectValues() throws {
        let orderDetails = OrderDetailsModel(number: "123", amount: 789, currency: .eur, paymentType: "credit-card", estimatedDeliveryDate: "23-11-2023", buyerEmail: "abc@xyz.com")
        XCTAssertTrue(
            orderDetails.number == "123",
            "OrderDetailsModel should be initialized with correct order number"
        )
        XCTAssertTrue(
            orderDetails.amount == 789,
            "OrderDetailsModel should be initialized with correct order amount"
        )
        XCTAssertTrue(
            orderDetails.currency.code == CurrencyCode.eur.code,
            "OrderDetailsModel should be initialized with correct order currency"
        )
    }
}
