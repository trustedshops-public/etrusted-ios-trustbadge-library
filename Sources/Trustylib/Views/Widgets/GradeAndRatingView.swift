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


import SwiftUI

/**
 GradeAndRatingView shows grade (Excellent, Good, Fair, etc) and rating details.
 Its a common view used for both shop grade and product grade widgets for displaying respective grade and rating.
 */
struct GradeAndRatingView: View {
    
    // MARK: Public properties
    
    var grade: String
    var gradeTitle: String
    var rating: Float
    var ratingFormatted: String
    var alignment: TrustbadgeViewAlignment
    var height: CGFloat
    var width: CGFloat
    
    // MARK: Private properties
    
    private var leadingPadding: CGFloat {
        return self.alignment == .leading ? self.height + self.horizontalPadding : self.horizontalPadding
    }
    
    private var trailingPadding: CGFloat {
        return self.alignment == .leading ? self.horizontalPadding : self.height + self.horizontalPadding
    }
    
    private let horizontalPadding: CGFloat = 12
    private let textScaleFactor = 0.5
    
    // MARK: User interface
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Grade Text
            HStack(alignment: .center, spacing: 5) {
                if self.alignment == .trailing {
                    Spacer()
                }
                
                Text(self.grade)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(self.textScaleFactor)
                Text(self.gradeTitle)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(self.textScaleFactor)
                
                if self.alignment == .leading {
                    Spacer()
                }
            }
            .padding(.leading, self.leadingPadding)
            .padding(.trailing, self.trailingPadding)
            
            // Star Rating View
            HStack(alignment: .center, spacing: 5) {
                if self.alignment == .trailing { Spacer() }
                
                StarRatingView(rating: self.rating)
                HStack(alignment: .center, spacing: 0) {
                    Text(self.ratingFormatted)
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                    Text("/5.00")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                }
                
                if self.alignment == .leading { Spacer() }
            }
            .padding(.leading, self.leadingPadding)
            .padding(.trailing, self.trailingPadding)
        }
    }
}

// MARK: Helper properties/methods for tests

extension GradeAndRatingView {
    var lPadding: CGFloat {
        return self.leadingPadding
    }
    
    var tPadding: CGFloat {
        return self.trailingPadding
    }
    
    var hPadding: CGFloat {
        return self.horizontalPadding
    }
}
