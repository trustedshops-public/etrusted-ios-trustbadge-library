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
 GradeAndRatingViewTests tests GradeAndRatingView UI workflows
 */
final class GradeAndRatingViewTests: XCTestCase {

    let channelId = "chl-b309535d-baa0-40df-a977-0b375379a3cc"
    let state: TrustbadgeState = .default(false)
    let alignment: TrustbadgeViewAlignment = .leading
    let width: CGFloat = 300
    let height: CGFloat = 75
    
    func testGradeAndRatingViewInitializesWithCorrectValues() throws {
        let gradeAndRatingView = GradeAndRatingView(
            grade: "Excellent",
            gradeTitle: "shop reviews",
            rating: 4.5,
            ratingFormatted: "4.5",
            alignment: .leading,
            height: self.height,
            width: self.width
        )
        
        let lPadding = gradeAndRatingView.alignment == .leading ? gradeAndRatingView.height + gradeAndRatingView.hPadding : gradeAndRatingView.hPadding
        XCTAssert(
            gradeAndRatingView.lPadding == lPadding,
            "GradeAndRatingView should calcualate leading padding correctly based on the alignment property"
        )
        
        let tPadding = gradeAndRatingView.alignment == .leading ? gradeAndRatingView.hPadding : gradeAndRatingView.height + gradeAndRatingView.hPadding
        XCTAssert(
            gradeAndRatingView.tPadding == tPadding,
            "GradeAndRatingView should calcualate trailing padding correctly based on the alignment property"
        )
    }
    
    func testShopGradeViewBodyIsNotNil() {
        let gradeAndRatingView = GradeAndRatingView(
            grade: "Excellent",
            gradeTitle: "shop reviews",
            rating: 4.5,
            ratingFormatted: "4.5",
            alignment: .leading,
            height: self.height,
            width: self.width
        )
        XCTAssertNotNil(
            gradeAndRatingView.body,
            "GradeAndRatingView body value should not be nil"
        )
    }

}
