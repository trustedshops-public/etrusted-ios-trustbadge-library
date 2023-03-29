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
//  Created by Prem Pratap Singh on 10/11/22.
//

import SwiftUI

/**
 TrustbadgeView is the main container view for showing different types of widgets like,
 1. TrustMark
 2. ShopGrade
 
 It expects TSID, channel id and context (.trustMark, .shopGrade, etc) during initialization. Based on these
 inputs, it communicates with the TrustedShop's authentication and data API for downloading given shop's
 detaills and presents on screen with a rich UI.
 */
public struct TrustbadgeView: View {

    // MARK: Public properties

    /// This boolean property controls the visibility of the trustbadge view
    public var isHidden: Bool = false {
        willSet {
            self.viewModel.currentState = newValue == true ? .invisible : .default(self.viewModel.isTrustmarkValid)
        }
    }

    // MARK: Private properties
    
    @StateObject private var viewModel: TrustbadgeViewModel
    
    private var tsid: String
    private var channelId: String
    private var alignment: TrustbadgeViewAlignment = .leading
    private var context: TrustbadgeContext
    private let badgeIconHeightPercentToBackgroudCircle: CGFloat = 0.8

    // MARK: Initializer

    public init(
        tsid: String,
        channelId: String,
        context: TrustbadgeContext) {
            self.tsid = tsid
            self.channelId = channelId
            self.context = context
            self._viewModel = StateObject(wrappedValue: TrustbadgeViewModel(context: context))
    }

    // MARK: User interface

    public var body: some View {
        GeometryReader { geoReader in

            let proposedWidth = geoReader.frame(in: .global).width
            let proposedHeight = geoReader.frame(in: .global).height
            HStack(alignment: .center) {

                // This spacer helps in keeping the trustmark icon and expanding view
                // aligned to the right
                if self.alignment == .trailing {
                    Spacer()
                }

                if self.viewModel.trustMarkDetails != nil {
                    ZStack(alignment: self.alignment == .leading ? .leading : .trailing) {

                        // Expendable view is added to the view only if the client id and
                        // client secret details were loaded from the configuration file
                        // which are reuired for showing shop grade, product grade, etc
                        
                        if TrustbadgeConfigurationService.shared.clientId != nil, TrustbadgeConfigurationService.shared.clientSecret != nil {

                            ZStack(alignment: .center) {
                                // Background
                                RoundedRectangle(cornerRadius: proposedHeight * 0.5)
                                    .fill(Color.white)
                                    .frame(
                                        width: self.viewModel.currentState == .default(self.viewModel.isTrustmarkValid) ? proposedHeight : proposedWidth,
                                        height: proposedHeight
                                    )
                                    .animation(.easeOut(duration: 0.3), value: self.viewModel.currentState)
                                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)

                                // Content - Shop grade, product grade, etc
                                ZStack {
                                    if self.context == .shopGrade {
                                        ShopGradeView(
                                            channelId: self.channelId,
                                            currentState: self.viewModel.currentState,
                                            alignment: self.alignment,
                                            isTrustmarkValid: self.viewModel.isTrustmarkValid,
                                            height: proposedHeight,
                                            width: proposedWidth,
                                            delegate: self
                                        )
                                    } else if self.context == .buyerProtection {
                                        BuyerProtectionView(
                                            tsid: self.tsid,
                                            currentState: self.viewModel.currentState,
                                            alignment: self.alignment,
                                            isTrustmarkValid: self.viewModel.isTrustmarkValid,
                                            height: proposedHeight,
                                            width: proposedWidth,
                                            delegate: self
                                        )
                                    }
                                }
                                .opacity(self.viewModel.shouldShowExpendedStateContent ? 1 : 0)
                                .animation(.easeIn(duration: 0.2), value: self.viewModel.shouldShowExpendedStateContent)
                            }
                        }

                        // Trustbadge Icon
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: proposedWidth, height: proposedHeight)
                                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 0)

                            if let image = self.viewModel.iconImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: proposedHeight * self.badgeIconHeightPercentToBackgroudCircle,
                                        height: proposedHeight * self.badgeIconHeightPercentToBackgroudCircle
                                    )
                            }
                        }
                        .frame(width: proposedHeight, height: proposedHeight)
                    }
                }

                // This spacer helps in keeping the trustmark icon and expanding view
                // aligned to the left
                if self.alignment == .leading {
                    Spacer()
                }
            }
        }
        .opacity(self.isHidden ? 0 : 1)
        .animation(.easeIn(duration: 0.2), value: self.isHidden)
        .onAppear {
            self.viewModel.getTrustmarkDetails(for: self.tsid)
        }
    }
}

// MARK: ShopGradeViewDelegate methods

extension TrustbadgeView: ShopGradeViewDelegate {
    func didLoadShopGrades() {
        self.viewModel.expandBadgeToShowDetails()
    }
}

// MARK: BuyerProtectionViewDelegate methods

extension TrustbadgeView: BuyerProtectionViewDelegate {
    func didLoadBuyerProtectionDetails() {
        self.viewModel.expandBadgeToShowDetails()
    }
}

// MARK: Helper properties/methods for tests

extension TrustbadgeView {
    
    var currentViewModel: TrustbadgeViewModel {
        return self.viewModel
    }
    
    var trustedShopId: String {
        return self.tsid
    }
    
    var currentChannelId: String {
        return self.channelId
    }
    
    var currentContext: TrustbadgeContext {
        return self.context
    }
}
