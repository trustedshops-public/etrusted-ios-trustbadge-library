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
//  Created by Prem Pratap Singh on 19/06/23.
//

import SwiftUI
import Combine

/**
 TrustbadgeColorSchemeManager reads client application information about weather the app
 forces light or dark color scheme via using `UIUserInterfaceStyle` info plist key and sets library
 color scheme accordingly.
 
 If in case, `UIUserInterfaceStyle` key isn't available in the plist, `TrustbadgeView` reads system
 color scheme information with `@Environment(\.colorScheme)` environment variable and calls
 `updateColorsForScheme(_ scheme: TrustbadgeColorScheme)` method for updating color
 codes and asset names based on the active color scheme. This automatically updates those views who use
 TrustbadgeColorSchemeManager color and asset names.
 */
class TrustbadgeColorSchemeManager: ObservableObject {
    
    // MARK: Public properties
    
    static let instance = TrustbadgeColorSchemeManager()
    
    @Published var trustCardBorderColor: Color = Color.tsPineapple500
    @Published var trustCardButtonColor: Color = Color.tsBlue700
    @Published var trustCardButtonBorderColor: Color = Color.tsBlue800
    @Published var trustCardButtonTitleTextColor: Color = Color.white
    @Published var trustCardBannerImageName: String?
    @Published var trustCardLinkColor: Color = Color.tsBlue700
    @Published var borderColor: Color = Color.tsGray50
    @Published var backgroundColor: Color = Color.white
    @Published var titleTextColor: Color = Color.white
    @Published var ratingTextColor: Color = Color.tsGray800
    @Published var ratingRangeTextColor: Color = Color.tsGray600
    var trustbadgeColorScheme: TrustbadgeColorScheme = .system
    
    
    // MARK: Private properties
    
    private let keyNameForAppearanceSettings = "UIUserInterfaceStyle"
    
    // MARK: Initializer
    
    private init() {
        self.getHostApplicationColorSchemeIfAvailable()
    }
    
    
    // MARK: Publci methods
    
    /**
     This method is called when user phone's settings for light/dark color scheme changes.
     Based on user phone's active color scheme, it updates library color codes and asset names
     so that trustbade widgets could update its color and assets based on active color scheme.
     */
    func updateColorsForScheme(_ scheme: TrustbadgeColorScheme) {
        self.trustCardBorderColor = scheme == .light ? Color.tsPineapple500 : Color.black
        self.trustCardButtonColor = scheme == .light ? Color.tsBlue700 : Color.tsBlue150
        self.trustCardButtonBorderColor = scheme == .light ? Color.tsBlue800 : Color.tsBlue150
        self.trustCardButtonTitleTextColor = scheme == .light ? Color.white : Color.black
        self.trustCardBannerImageName = scheme.trustCardBannerImageName
        self.trustCardLinkColor = scheme == .light ? Color.tsBlue700 : Color.white
        self.borderColor = scheme == .light ? Color.tsGray50 : Color.tsGray700
        self.backgroundColor = scheme == .light ? Color.white : Color.tsGray800
        self.titleTextColor = scheme == .light ? Color.black : Color.white
        self.ratingTextColor = scheme == .light ? Color.tsGray800 : Color.white
        self.ratingRangeTextColor = scheme == .light ? Color.tsGray600 : Color.white
    }
    
    
    // MARK: Private methods
    
    /**
     It looks for `UIUserInterfaceStyle` key/value pair in the host application plist file.
     If found, it sets the trustbadge color scheme based on the value set fot this key.
     Else, trustbadge color scheme is set to default value `system`
     */
    private func getHostApplicationColorSchemeIfAvailable() {
        guard let scheme = Bundle.main.object(forInfoDictionaryKey: self.keyNameForAppearanceSettings) as? String else {
            self.trustbadgeColorScheme = .system
            return
        }
        self.setTrustbadgeSchemeFor(schemeName: scheme)
    }
    
    /**
     It sets active color scheme for Trustbadge based on the given scheme name
     */
    private func setTrustbadgeSchemeFor(schemeName: String) {
        if schemeName.lowercased() == TrustbadgeColorScheme.light.name {
            self.trustbadgeColorScheme = .light
        } else if schemeName.lowercased() == TrustbadgeColorScheme.dark.name {
            self.trustbadgeColorScheme = .dark
        }
        
        self.updateColorsForScheme(self.trustbadgeColorScheme)
    }
}

// MARK: Helper function for unit tests

extension TrustbadgeColorSchemeManager {
    func testSettingTrustbadgeSchemeFor(schemeName: String) {
        self.setTrustbadgeSchemeFor(schemeName: schemeName)
    }
}
