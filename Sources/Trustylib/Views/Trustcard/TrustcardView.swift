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
//  Created by Prem Pratap Singh on 10/09/23.
//


import SwiftUI


/**
 TrustcardViewDelegate is updated about  trust card view's internal events
 so that required actions be taken at the parent view level.
 */
protocol TrustcardViewDelegate {
    func didTapOnDismissTrustcardButton()
}

/**
 TrustcardView presents UI/UX showing details about the buyer protection support and
 action buttons for subscribing to buyer protection, upgrading to plus protection and
 other buyer protection related workflows.
 */
struct TrustcardView: View {
    
    // MARK: - Public properties
    
    var trustMarkDetails: TrustmarkDetailsModel?
    @Binding var orderDetails: OrderDetailsModel?
    var protectionAmountWithCurrencyCode: String?
    @Binding var state: TrustcardState?
    @Binding var height: CGFloat
    var delegate: TrustcardViewDelegate
    
    // MARK: - Private properties
    
    @StateObject private var colorSchemeManager = TrustbadgeColorSchemeManager.instance
    
    // MARK: - User interface
    
    var body: some View {
        ZStack {
            if let trustMarkDetails = self.trustMarkDetails, let consumerOrderDetails = self.orderDetails, let protectionAmount = self.protectionAmountWithCurrencyCode, let trustCardState = self.state {
                // Buyer protection content view
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Text(trustCardState.getTitle(with: protectionAmount)).font(.system(size: 16, weight: .semibold)).fixedSize(horizontal: false, vertical: true)
                        Spacer(minLength: 10)
                        Button(
                            action: { self.didTapOnDismissButton() },
                            label: { Image(systemName: "xmark").frame(width: 18, height: 18).foregroundColor(self.colorSchemeManager.titleTextColor) }
                        )
                    }
                    
                    switch trustCardState {
                    case .classicProtection: ClassicProtectionView(trustMarkDetails: trustMarkDetails, orderDetails: consumerOrderDetails, protectionAmountWithCurrencyCode: protectionAmount, delegate: self)
                    case .protectionConfirmation: ProtectionConfirmationView()
                    }
                }
                .padding(.all, 18)
                
                // Border graphics
                TrustcardBorderGraphics()
            }
        }
        .background(GeometryReader { geometry in
            self.colorSchemeManager.backgroundColor.preference(key: TrustcardHeightPreferenceKey.self, value: geometry.size.height)
        })
        .onPreferenceChange(TrustcardHeightPreferenceKey.self) { self.height = $0 }
    }
    
    // MARK: - Private methods
    
    /**
     Resets trustcard state when user taps on the dismiss button
     */
    private func didTapOnDismissButton() {
        self.delegate.didTapOnDismissTrustcardButton()
        self.orderDetails = nil
        self.state = nil
    }
}

// MARK: - ClassicProtectionViewDelegate methods

extension TrustcardView: ClassicProtectionViewDelegate {
    func didTapOnSubscribeToProtectionButton() { self.state = .protectionConfirmation }
}

/**
 TrustcardHeightPreferenceKey helps in keeping track of changes in trustcard view height
 */
struct TrustcardHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = max(value, nextValue()) }
}

/**
 TrustedShops urls for Trustcard related terms conditions, privacy policy, imprint etc
 */
extension TrustcardView {
    static var urlForTermsConditionsAndPrivacyPolicy: String {
        return "https://www.trustedshops.com/tsdocument/BUYER_AUTO_PROTECTION_TERMS_en.pdf"
    }
    
    static var urlForImprintAndDataProtection: String {
        return "https://www.trustedshops.co.uk/imprint/#user-privacy-policy"
    }
}

/**
 Unit/UI test helper methods
 */
extension TrustcardView {
    func tapOnDismissButton() { self.didTapOnDismissButton() }
    func tapOnSubscribeToProtectionButton() { self.didTapOnSubscribeToProtectionButton() }
}
