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
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI

/**
This view represents the star rating view based on the given rating value
 */
struct StarRatingView: View {

    // MARK: Private property

    private static let maxRating: Float = 5
    private static let filledStarColor = Color.tsPineapple500
    private static let emptyStarColor = Color.tsGray100

    private let rating: Float
    private let fullCount: Int
    private let emptyCount: Int
    private let halfFullCount: Int
    
    private var fullStar: some View {
        StarView(corners: 5, smoothness: 0.45)
            .fill(StarRatingView.filledStarColor)
    }

    private var halfFullStar: some View {
        StarView(corners: 5, smoothness: 0.45)
            .fill(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: StarRatingView.filledStarColor, location: 0.5),
                        Gradient.Stop(color: StarRatingView.emptyStarColor, location: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
            )
        )
    }

    private var emptyStar: some View {
        StarView(corners: 5, smoothness: 0.45)
            .fill(StarRatingView.emptyStarColor)
    }

    // MARK: Initializer

    init(rating: Float) {
        self.rating = rating
        self.fullCount = Int(rating)
        self.emptyCount = Int(StarRatingView.maxRating - rating)
        self.halfFullCount = (Float(fullCount + emptyCount) < StarRatingView.maxRating) ? 1 : 0
    }

    // MARK: User interface
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<fullCount, id: \.self) { _ in
                self.fullStar
                    .frame(width: 17, height: 16)
            }
            ForEach(0..<halfFullCount, id: \.self) { _ in
                self.halfFullStar
                    .frame(width: 17, height: 16)
            }
            ForEach(0..<emptyCount, id: \.self) { _ in
                self.emptyStar
                    .frame(width: 17, height: 16)
            }
        }
        .frame(width: 105, height: 16)
    }
}

// MARK: Helper methods/properties for tests

extension StarRatingView {
    var fullStarView: any View {
        return self.fullStar
    }
    
    var halfFullStarView: any View {
        return self.halfFullStar
    }
    
    var emptyStarView: any View {
        return self.emptyStar
    }
}
