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
//  Created by Prem Pratap Singh on 24/04/23.
//


import XCTest
@testable import Trustylib

/**
 CurrencyCodeTests tests currency code enum initialization and accuracy of currency code and symol
 */
final class CurrencyCodeTests: XCTestCase {
    
    func testCurrencyCodeIntializesWithCorrectCurrency() {
        let currencyCode = CurrencyCode(rawValue: "chf")
        XCTAssertTrue(
            currencyCode?.symbol == "CHF",
            "Currency code should be initialized with correct currency code"
        )
    }
    
    func testCurrencyCodeReturnsValidCodeAndSymbol() {
        let currencyCodeChf = CurrencyCode(rawValue: "chf")
        XCTAssertTrue(
            currencyCodeChf?.code == "CHF",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodeChf?.symbol == "CHF",
            "Currency code should return correct currency symbol"
        )
        
        let currencyCodeEur = CurrencyCode(rawValue: "eur")
        XCTAssertTrue(
            currencyCodeEur?.code == "EURO",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodeEur?.symbol == "€",
            "Currency code should return correct currency symbol"
        )
        
        let currencyCodeGbp = CurrencyCode(rawValue: "gbp")
        XCTAssertTrue(
            currencyCodeGbp?.code == "GBP",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodeGbp?.symbol == "£",
            "Currency code should return correct currency symbol"
        )
        
        let currencyCodePln = CurrencyCode(rawValue: "pln")
        XCTAssertTrue(
            currencyCodePln?.code == "PLN",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodePln?.symbol == "zł",
            "Currency code should return correct currency symbol"
        )
        
        let currencyCodeNok = CurrencyCode(rawValue: "nok")
        XCTAssertTrue(
            currencyCodeNok?.code == "NOK",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodeNok?.symbol == "kr",
            "Currency code should return correct currency symbol"
        )
        
        let currencyCodeCzk = CurrencyCode(rawValue: "czk")
        XCTAssertTrue(
            currencyCodeCzk?.code == "CZK",
            "Currency code should return correct currency code"
        )
        XCTAssertTrue(
            currencyCodeCzk?.symbol == "Kč",
            "Currency code should return correct currency symbol"
        )
    }
}
