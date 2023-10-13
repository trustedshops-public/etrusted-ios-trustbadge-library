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
 ClassicProtectionView presents UI/UX and user action buttons for `TrustcardState.protectionConfirmation` state
 */
struct ProtectionConfirmationView: View {
    
    // MARK: - Private properties
    
    @StateObject private var colorSchemeManager = TrustbadgeColorSchemeManager.instance
    
    private var termsAndConditionsLinkText: String {
        let text = NSLocalizedString("[Terms & conditions](%@)", comment: "Protection confirmation view - terms and conditions")
        let linkText = String(format: text, TrustcardView.urlForTermsConditionsAndPrivacyPolicy)
        return linkText
    }
    
    private var imprintLinkText: String {
        let text = NSLocalizedString("[Imprint & Data protection](%@)", comment: "Protection confirmation view - imprint")
        let linkText = String(format: text, TrustcardView.urlForImprintAndDataProtection)
        return linkText
    }
    
    // MARK: - User interface
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(NSLocalizedString("Trusted Shops will send you an email in order to review your order.", comment: "Buyer protection confirmation - description")).font(.system(size: 13, weight: .regular)).foregroundColor(self.colorSchemeManager.titleTextColor).fixedSize(horizontal: false, vertical: true).padding(.bottom, 40)
            
            Text(.init(self.termsAndConditionsLinkText)).font(.system(size: 11, weight: .regular)).accentColor(self.colorSchemeManager.trustCardLinkColor).foregroundColor(self.colorSchemeManager.titleTextColor)
            Text(.init(self.imprintLinkText)).font(.system(size: 11, weight: .regular)).accentColor(self.colorSchemeManager.trustCardLinkColor).foregroundColor(self.colorSchemeManager.titleTextColor)
        }
        
    }
}
