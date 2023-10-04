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
//  Created by Prem Pratap Singh on 03/10/23.
//


import Foundation
import Mixpanel

class TrustbadgeAnalyticsService {
    
    // MARK: - Public properties
    
    static var instance = TrustbadgeAnalyticsService()
    
    
    // MARK: - Constructor
    
    private init() {}
    
    
    // MARK: - Public methods
    
    func setupAnalyticsEnvironment(trustbadgeEnvironment: TSEnvironment) {
        self.setupMixPanelAnalyticsEnvironment(trustbadgeEnvironment: trustbadgeEnvironment)
    }
    
    func logEvent(event: TrustylibAnalyticsEvent) {
        Mixpanel.mainInstance().track(event: event.name, properties: nil)
    }
    
    // MARK: - Private methods
    
    private func setupMixPanelAnalyticsEnvironment(trustbadgeEnvironment: TSEnvironment) {
        switch trustbadgeEnvironment {
        case .production:
            Mixpanel.initialize(token: "e048ab5d664076a2c9ac67d1d3e00f5a", trackAutomaticEvents: false)
        default:
            Mixpanel.initialize(token: "9f51c2de34e2c17126f28fd7c13b21c3", trackAutomaticEvents: false)
        }
    }
}

enum TrustylibAnalyticsEvent {
    case trustbadgePresented, trustbadgeClicked
    
    var name: String {
        switch self {
        case .trustbadgePresented: return "trustbadge_presented"
        case .trustbadgeClicked: return "trustbadge_clicked"
        }
    }
}
