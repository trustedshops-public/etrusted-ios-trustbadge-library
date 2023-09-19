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

final class TrustcardBorderGraphicsTests: XCTestCase {

    func testTrustcardBorderGraphicsBodyIsNotNil() throws {
        let graphics = TrustcardBorderGraphics()
        XCTAssertNotNil(
            graphics.body,
            "TrustcardBorderGraphics body shouldn't return nil value"
        )
    }
    
    func testTrustcardBorderGraphicsLoadsBannerImageCorrectly() throws {
        let graphics = TrustcardBorderGraphics()
        graphics.loadBannerGraphics(name: "trustcardBanner-Dark") { didLoadGraphics in
            XCTAssertTrue(
                didLoadGraphics,
                "TrustcardBorderGraphics should load banner graphics from resource bundle correctly"
            )
        }
        graphics.loadBannerGraphics(name: "trustcardBanner") { didLoadGraphics in
            XCTAssertFalse(
                didLoadGraphics,
                "TrustcardBorderGraphics should load banner graphics from resource bundle correctly"
            )
        }
    }
}