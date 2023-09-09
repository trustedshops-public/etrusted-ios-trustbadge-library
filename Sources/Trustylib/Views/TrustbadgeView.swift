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
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: TrustbadgeViewModel
    @StateObject private var colorSchemeManager = TrustbadgeColorSchemeManager.instance
    
    private let badgeIconHeightPercentToBackgroudCircle: CGFloat = 0.8
    
    // MARK: Initializer
    
    public init(
        tsId: String,
        channelId: String? = nil,
        productId: String? = nil,
        orderDetails: OrderDetailsModel? = nil,
        trustCardState: TrustcardState? = nil,
        context: TrustbadgeContext,
        alignment: TrustbadgeViewAlignment = .leading
    ) {
        self._viewModel = StateObject(
            wrappedValue: TrustbadgeViewModel(
                tsId: tsId,
                channelId: channelId,
                productId: productId,
                orderDetails: orderDetails,
                trustCardState: trustCardState,
                context: context,
                alignment: alignment
            )
        )
    }
    
    // MARK: User interface
    
    public var body: some View {
        GeometryReader { geoReader in
            self.getRootViewWith(proposedWidth: geoReader.frame(in: .global).width, proposedHeight: geoReader.frame(in: .global).height)
        }
        .opacity(self.isHidden ? 0 : 1)
        .animation(.easeIn(duration: 0.2), value: self.isHidden)
        .environmentObject(self.colorSchemeManager)
        .onChange(of: self.colorScheme) { scheme in
            self.updateLibraryColorScheme(for: scheme)
        }
        .onAppear {
            self.updateLibraryColorScheme(for: self.colorScheme)
            self.viewModel.getTrustmarkDetails()
        }
    }
    
    // MARK: Private methods
    
    /**
     Builds up trustbadge root view based on available width, height, view model data and returns the same
     */
    private func getRootViewWith(proposedWidth: CGFloat, proposedHeight: CGFloat) -> some View {
        
        return HStack(alignment: .center) {
            
            // This spacer helps in keeping the trustmark icon and expanding view
            // aligned to the right
            if self.viewModel.alignment == .trailing { Spacer(minLength: 0) }
            
            ZStack(alignment: self.viewModel.alignment == .leading ? .leading : .trailing) {
                
                // Expendable view is added to the view only if the client id and
                // client secret details were loaded from the configuration file
                // which are reuired for showing shop grade, product grade, etc
                
                if self.viewModel.areBadgeInputsValid {
                    
                    ZStack(alignment: .center) {
                        // Background
                        ZStack {
                            RoundedRectangle(cornerRadius: proposedHeight * 0.5)
                                .fill(self.colorSchemeManager.backgroundColor)
                                .frame(
                                    width: self.viewModel.currentState == .default(self.viewModel.isTrustmarkValid) ? proposedHeight : proposedWidth,
                                    height: proposedHeight
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
                                .animation(.easeOut(duration: 0.3), value: self.viewModel.currentState)
                            
                            RoundedRectangle(cornerRadius: proposedHeight * 0.5)
                                .stroke(self.colorSchemeManager.borderColor, lineWidth: 1)
                                .frame(
                                    width: self.viewModel.currentState == .default(self.viewModel.isTrustmarkValid) ? proposedHeight : proposedWidth,
                                    height: proposedHeight
                                )
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
                                .animation(.easeOut(duration: 0.3), value: self.viewModel.currentState)
                        }
                        
                        // Content - Shop grade, product grade, etc
                        ZStack {
                            if self.viewModel.context == .shopGrade {
                                if let channelId = self.viewModel.channelId {
                                    ShopGradeView(
                                        channelId: channelId,
                                        currentState: self.viewModel.currentState,
                                        alignment: self.viewModel.alignment,
                                        isTrustmarkValid: self.viewModel.isTrustmarkValid,
                                        height: proposedHeight,
                                        width: proposedWidth,
                                        delegate: self
                                    )
                                }
                            } else if self.viewModel.context == .buyerProtection {
                                BuyerProtectionView(
                                    tsid: self.viewModel.tsId,
                                    currentState: self.viewModel.currentState,
                                    alignment: self.viewModel.alignment,
                                    isTrustmarkValid: self.viewModel.isTrustmarkValid,
                                    height: proposedHeight,
                                    width: proposedWidth,
                                    delegate: self
                                )
                            } else if self.viewModel.context == .productGrade {
                                if let channelId = self.viewModel.channelId,
                                   let productId = self.viewModel.productId {
                                    ProductGradeView(
                                        channelId: channelId,
                                        productId: productId,
                                        currentState: self.viewModel.currentState,
                                        alignment: self.viewModel.alignment,
                                        isTrustmarkValid: self.viewModel.isTrustmarkValid,
                                        height: proposedHeight,
                                        width: proposedWidth,
                                        delegate: self
                                    )
                                }
                            }
                        }
                        .opacity(self.viewModel.shouldShowExpendedStateContent ? 1 : 0)
                        .animation(.easeIn(duration: 0.2), value: self.viewModel.shouldShowExpendedStateContent)
                    }
                }
                
                // Trustbadge Icon
                ZStack(alignment: .center) {
                    Circle()
                        .fill(self.colorSchemeManager.backgroundColor)
                        .frame(width: proposedWidth, height: proposedHeight)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
                    
                    if let image = self.viewModel.iconImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: proposedHeight * self.badgeIconHeightPercentToBackgroudCircle, height: proposedHeight * self.badgeIconHeightPercentToBackgroudCircle)
                            .clipShape(Circle())
                            .padding(.all, 5)
                    }
                }
                .opacity(self.viewModel.trustMarkDetails != nil ? 1 : 0)
                .frame(width: proposedHeight, height: proposedHeight)
            }
            
            // This spacer helps in keeping the trustmark icon and expanding view
            // aligned to the left
            if self.viewModel.alignment == .leading { Spacer(minLength: 0) }
        }
    }
    
    /**
     It passes on the updated color scheme to the color scheme manager so that the library's color and
     assets could be updated.
     */
    private func updateLibraryColorScheme(for scheme: ColorScheme) {
        // Trustbadge widgets need to update color and assets only when the host application
        // doesn't enforce light or dark mode with `UIUserInterfaceStyle` key in info.plist.
        // This means that `colorSchemeManager.trustbadgeColorScheme` will have `system` value.
        guard self.colorSchemeManager.trustbadgeColorScheme == .system else {
            self.viewModel.colorScheme = self.colorSchemeManager.trustbadgeColorScheme
            return
        }
        self.viewModel.colorScheme = scheme == .light ? .light : .dark
        self.colorSchemeManager.updateColorsForScheme(scheme == .light ? .light : .dark)
    }
}

// MARK: ShopGradeViewDelegate methods

extension TrustbadgeView: ShopGradeViewDelegate {
    func didLoadShopGrades() {
        self.viewModel.expandBadgeToShowDetails()
    }
}

// MARK: ProductGradeViewDelegate methods

extension TrustbadgeView: ProductGradeViewDelegate {
    func didLoadProductDetails(imageUrl: String) {
        self.viewModel.loadProductImageAndSetAsBadgeIcon(url: imageUrl) { _ in
            self.viewModel.expandBadgeToShowDetails()
        }
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
    
    func getTestRootViewWith(proposedWidth: CGFloat, proposedHeight: CGFloat) -> some View {
        return self.getRootViewWith(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
    }
}
