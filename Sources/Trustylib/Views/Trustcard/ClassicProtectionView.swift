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
 ClassicProtectionViewDelegate is updated about  classic protection trust card view's
 internal events so that required actions be taken at the parent view level.
 */
protocol ClassicProtectionViewDelegate {
    func didTapOnSubscribeToProtectionButton()
}

/**
 ClassicProtectionView presents UI/UX and user action buttons for `TrustcardState.classicProtection` state
 */
struct ClassicProtectionView: View {
    
    // MARK: - Public properties
    
    var trustMarkDetails: TrustmarkDetailsModel
    var orderDetails: OrderDetailsModel
    var protectionAmountWithCurrencyCode: String
    var delegate: ClassicProtectionViewDelegate
    
    // MARK: - Private properties
    
    private var protectionTerms: [String] {
        let protectionAmountString = NSLocalizedString("Automatic guarantee up to %@ for all purchases", comment: "Classic buyer protection - gurantee amount")
        let protectionAmountStringFormatted = String(format: protectionAmountString, self.protectionAmountWithCurrencyCode)
        return [
            protectionAmountStringFormatted,
            NSLocalizedString("Available in shops with the Trusted Shops trustmark", comment: "Classic buyer protection - availability"),
            NSLocalizedString("All benefits of the Trusted Shops services", comment: "Classic buyer protection - benefits")
        ]
    }
    
    private var descriptionText: String {
        let textOne = NSLocalizedString("We may ask for further review information by e-mail to help other online shoppers.", comment: "Classic buyer protection - description")
        let textTwo = NSLocalizedString("[Terms and Conditions & Privacy Policy](%@)", comment: "Classic buyer protection - terms and conditions")
        let string = String(format: "\(textOne) \(textTwo)", TrustcardView.urlForTermsConditionsAndPrivacyPolicy)
        return string
    }
    
    private var imprintLinkText: String {
        let text = NSLocalizedString("[Imprint](%@)", comment: "Classic buyer protection - imprint")
        let linkText = String(format: text, TrustcardView.urlForImprintAndDataProtection)
        return linkText
    }
    
    // MARK: - User interface
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Shop name and order amount
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(NSLocalizedString("Shop", comment: "Classic buyer protection - shop name")).font(.system(size: 13, weight: .regular)).foregroundColor(Color.black)
                    Text("\(self.trustMarkDetails.name)").font(.system(size: 16, weight: .regular)).foregroundColor(Color.black)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text(NSLocalizedString("Order amount", comment: "Classic buyer protection - order amount")).font(.system(size: 13, weight: .regular)).foregroundColor(Color.black)
                    Text("\(self.orderDetails.amount.formatted()) \(self.orderDetails.currency.symbol)").font(.system(size: 16, weight: .regular)).foregroundColor(Color.black)
                }
            }
            
            // Protection terms
            VStack(alignment: .leading, spacing: 14) {
                ForEach(self.protectionTerms, id: \.self) { term in ProtectionTermsView(term: term) }
            }
            
            // Link to Terms/Conditions and Privacy Policy
            Text(.init(self.descriptionText)).font(.system(size: 11, weight: .regular)).accentColor(Color.tsBlue700).foregroundColor(Color.black).fixedSize(horizontal: false, vertical: true)
            
            
            // Click to action button
            Button(
                action: { self.delegate.didTapOnSubscribeToProtectionButton() },
                label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.tsBlue800, lineWidth: 1).frame(height: 43).background(RoundedRectangle(cornerRadius: 6).fill(Color.tsBlue700))
                        Text(NSLocalizedString("Protect your purchase for free", comment: "Classic buyer protection - subscribe to protection button title")).font(.system(size: 16, weight: .semibold)).foregroundColor(Color.white)
                    }
                }
            )
            .padding(.horizontal, 16)
            
            Spacer(minLength: 20)
            
            // Link to imprint and data protection
            Text(.init(self.imprintLinkText)).font(.system(size: 11, weight: .regular)).accentColor(Color.tsBlue700).foregroundColor(Color.tsGray700).fixedSize(horizontal: false, vertical: true).padding(.bottom, 10)
        }
    }
}
