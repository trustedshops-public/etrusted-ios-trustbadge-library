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
//  Created by Prem Pratap Singh on 24/11/22.
//

import SwiftUI

/**
 ShopGradeViewDelegate performs actions as delegated from the shop grade view.
 For example, when the shop grade details are loaded, the parent view is informed about the event
 so that the required actions be taken.
 */
protocol ShopGradeViewDelegate: Any {
    func didLoadShopGrades()
}

/**
 ShopGradeView calls Trustedshops backend API to load shop grade details and
 on load, it then shows the shop grade details with graphics and animated effects.
 */
struct ShopGradeView: View {
    
    // MARK: Public properties
    
    var channelId: String
    var currentState: TrustbadgeState
    var alignment: TrustbadgeViewAlignment
    var isTrustmarkValid: Bool = false
    var height: CGFloat
    var width: CGFloat
    var delegate: ShopGradeViewDelegate?
    
    // MARK: Private properties
    
    @StateObject private var viewModel = ShopGradeViewModel()
    
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
                // Shop Grade Text
                HStack(alignment: .center, spacing: 5) {
                    if self.alignment == .trailing {
                        Spacer()
                    }
                    
                    Text("\(self.viewModel.shopGrade)")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                    Text(NSLocalizedString("shops reviews",
                                           comment: "Trustbadge: Shop grade title"))
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
                    
                    StarRatingView(rating: self.viewModel.shopRating)
                    HStack(alignment: .center, spacing: 0) {
                        Text("\(self.viewModel.shopRatingFormatted)")
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
            self.viewModel.loadAggregateRating(for: self.channelId) { didLoadDetails in
                guard didLoadDetails else { return }
                self.delegate?.didLoadShopGrades()
            }
        }
    }
}

// MARK: Helper properties/methods for tests

extension ShopGradeView {
    
    var currentViewModel: ShopGradeViewModel {
        return self.viewModel
    }
    
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
