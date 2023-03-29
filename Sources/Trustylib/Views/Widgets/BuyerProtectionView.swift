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
//  Created by Prem Pratap Singh on 29/03/23.
//


import SwiftUI

/**
 BuyerProtectionViewDelegate performs actions as delegated from the buyer protection widget view.
 For example, when the shop's buyer protection details are loaded, the parent view is informed about the event
 so that the required actions be taken.
 */
protocol BuyerProtectionViewDelegate {
    func didLoadBuyerProtectionDetails()
}

/**
 BuyerProtectionView calls Trustedshops backend API to load shop's buyer protection details and
 on successful load, it then shows the details with graphics and animated effects.
 */
struct BuyerProtectionView: View {
    
    // MARK: Public properties
    
    var tsid: String
    var currentState: TrustbadgeState
    var alignment: TrustbadgeViewAlignment
    var isTrustmarkValid: Bool = false
    var height: CGFloat
    var width: CGFloat
    var delegate: BuyerProtectionViewDelegate?
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = BuyerProtectionViewModel()
    
    private let horizontalPadding: CGFloat = 12
    private let textScaleFactor = 0.5
    
    private var leadingPadding: CGFloat {
        return self.alignment == .leading ? self.height + self.horizontalPadding : self.horizontalPadding
    }
    
    private var trailingPadding: CGFloat {
        return self.alignment == .leading ? self.horizontalPadding : self.height + self.horizontalPadding
    }
    
    // MARK: User interface
    
    var body: some View {
        HStack(spacing: 0) {
            if let buyerProtectionDetails = self.viewModel.buyerProtectionDetails {
                if self.alignment == .trailing {
                    Spacer()
                }
                
                VStack(alignment: self.alignment == .leading ? .leading : .trailing, spacing: 4) {
                    Text(NSLocalizedString("Independent guarantee",
                                           comment: "Trustbadge: Buyer protection title"))
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(self.textScaleFactor)
                    
                    HStack(alignment: .center, spacing: 3) {
                        Text(NSLocalizedString("Your purchase is protected up to",
                                               comment: "Trustbadge: Buyer protection description"))
                        .foregroundColor(.black)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                        
                        Text("€\(buyerProtectionDetails.guarantee.protectionAmountFormatted)")
                        .foregroundColor(.black)
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(self.textScaleFactor)
                    }
                }
                .padding(.leading, self.leadingPadding)
                .padding(.trailing, self.trailingPadding)
                
                if self.alignment == .leading {
                    Spacer()
                }
            }
        }
        .frame(
            width: self.currentState == .default(self.isTrustmarkValid) ? 0 : self.width,
            height: self.height
        )
        .onAppear {
            self.loadBuyerProtectionDetails()
        }
    }
    
    // MARK: Private methods
    
    /**
     Calls view model to load buyer protection details
     */
    private func loadBuyerProtectionDetails() {
        self.viewModel.loadBuyerProtectionDetails(for: self.tsid) { didLoadDetails in
            guard didLoadDetails else { return }
            self.delegate?.didLoadBuyerProtectionDetails()
        }
    }
}
