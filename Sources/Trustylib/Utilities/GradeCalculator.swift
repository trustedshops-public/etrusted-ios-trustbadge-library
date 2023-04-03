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
//  Created by Prem Pratap Singh on 31/03/23.
//


import Foundation

/**
 GradeCalculator is a utility class that provides functionality related to ratings and grades
 */
class GradeCalculator {
    
    /**
     Returns grade for given rating value based on Trustedshop's logic shared across different platforms
     */
    static func getGradeForRating(_ rating: Float) -> String {
        if rating >= 4.5 {
            return NSLocalizedString("Excellent", comment: "Excellent shop grade text")
        } else if rating >= 3.5 && rating < 4.5 {
            return NSLocalizedString("Good", comment: "Good shop grade text")
        } else if rating >= 2.5 && rating < 3.5 {
            return NSLocalizedString("Fair", comment: "Fair shop grade text")
        } else if rating >= 1.5 && rating < 2.5 {
            return NSLocalizedString("Poor", comment: "Poor shop grade text")
        }

        // If rating is less than 1.5
        return NSLocalizedString("Very poor", comment: "Very poor shop grade text")
    }
}
