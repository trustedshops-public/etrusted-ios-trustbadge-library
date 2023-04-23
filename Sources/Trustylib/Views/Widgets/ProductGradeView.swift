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
//  Created by Prem Pratap Singh on 21/04/23.
//


import SwiftUI

/**
 ProductGradeViewDelegate performs actions as delegated from the product grade view.
 For example, when the product image and grade details are loaded, the parent view is informed
 about the event so that the required actions be taken.
 */
protocol ProductGradeViewDelegate: Any {
    func didLoadProductDetails(imageUrl: String)
}

/**
 ProductGradeView uses ProductGradeViewModel to communicate with the TrustedShop's API for
 loading product details (gtin, name, image url, etc) and product grade details.
 
 On successful data load, it then shows the product image and  grade details with graphics and animated effects.
 */
struct ProductGradeView: View {
    // MARK: Public properties
    
    var channelId: String
    var productId: String
    var currentState: TrustbadgeState
    var alignment: TrustbadgeViewAlignment
    var isTrustmarkValid: Bool = false
    var height: CGFloat
    var width: CGFloat
    var delegate: ProductGradeViewDelegate?
    
    // MARK: Private properties
    
    @StateObject private var viewModel = ProductGradeViewModel()
    
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
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                // Product Grade Text
                HStack(alignment: .center, spacing: 5) {
                    if self.alignment == .trailing {
                        Spacer()
                    }
                    
                    Text("\(self.viewModel.productGrade)")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                    Text(NSLocalizedString("product reviews",
                                           comment: "Trustbadge: Product grade title"))
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
                    if self.alignment == .trailing {
                        Spacer()
                    }
                    
                    StarRatingView(rating: self.viewModel.productRating)
                    HStack(alignment: .center, spacing: 0) {
                        Text("\(self.viewModel.productRatingFormatted)")
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
                    
                    if self.alignment == .leading {
                        Spacer()
                    }
                }
                .padding(.leading, self.leadingPadding)
                .padding(.trailing, self.trailingPadding)
            }
        }
        .frame(
            width: self.currentState == .default(self.isTrustmarkValid) ? 0 : self.width,
            height: self.height
        )
        .onAppear {
            self.getProductDetailsAndRatings()
        }
    }
    
    // MARK: Private methods
    
    /**
     Calls view model to load product details and ratings.
     On successful load of the  details and ratings, it then calls delegate to show product details and ratings.
     */
    private func getProductDetailsAndRatings() {
        self.viewModel.loadProductRating(for: self.channelId, productId: self.productId) { didLoadRatings in
            guard didLoadRatings else { return }
            self.viewModel.loadProductDetails(for: self.channelId, productId: self.productId) { _ in
                self.delegate?.didLoadProductDetails(imageUrl: self.viewModel.productImageUrl)
            }
        }
    }
}
