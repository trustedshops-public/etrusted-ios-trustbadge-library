//
//  StarRatingView.swift
//  Trustylib
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

struct B2CStarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 3.5)
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
