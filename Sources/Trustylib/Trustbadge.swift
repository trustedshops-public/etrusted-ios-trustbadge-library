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
//  Created by Prem Pratap Singh on 24/01/23.
//

import Foundation

/**
 Trustbadge is the main interface for Trustylib library and has a static method named `configure`
 that needs to be called before integrating the library widgets.

 The configure method looks for a required trustylib configuration file named `TrustbadgeConfiguration.plist`
 with important details like `client id`, `client secret`, etc which are required to load shop grades, product grades, etc
 */
public class Trustbadge {


    // MARK: Public methods

    /**
     Calls TrustbadgeConfigurationService to load the required libary configuration details.
     */
    public static func configure() {
        do {
            try TrustbadgeConfigurationService.shared.loadConfiguration(from: Bundle.main)
        } catch {
            TSConsoleLogger.log(
                messege: "Error loading trustbadge configuration. Please check if the application has valid TrustbadgeConfiguration.plist file with required key value pairs. Trustylib library's Git project readme has more details about the required configuration file.",
                severity: .error
            )
        }
    }
}
