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
import SwiftUI
@testable import Trustylib

/**
 This test suite tests initialization workflow for TrustbadgeViewWrapper view component
 */
final class TrustbadgeViewWrapperTests: XCTestCase {

    func testTrustbadgeViewWrapperInstantiatesValidTrustbadgeView() throws {
        let trustbadgeView = TrustbadgeViewWrapper.createTrustbadgeView(
            tsId: "X330A2E7D449E31E467D2F53A55DDD070",
            channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
            context: .trustMark
        )
        
        XCTAssertNotNil(
            trustbadgeView,
            "TrustbadgeViewWrapper should instantiate a valid trustbadge view"
        )
    }
}
