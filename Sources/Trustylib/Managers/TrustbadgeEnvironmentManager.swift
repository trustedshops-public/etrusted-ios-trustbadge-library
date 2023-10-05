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
//  Created by Prem Pratap Singh on 05/10/23.
//


import Foundation

/**
 TrustbadgeEnvironmentManager sets the current Trustbadge environment (development, stage, production) based
 on the configuration provided with build settings and info plist key-value pairs. Setting up the correct environment is
 very crucial as it helps in pointing to the right backend and other APIs.
 */
class TrustbadgeEnvironmentManager {
    
    // MARK: - Public properties
    
    /// Returns singleton instance
    public static var shared = TrustbadgeEnvironmentManager()
    
    /// Active Trustbadge environment
    var currentEnvironment: TrustbadgeEnvironment = .production
    
    // MARK: - Private properties
    
    private let environmentVariablesKey = "LSEnvironment"
    private let environmentKey = "TrustbadgeEnvironment"
    private let buildEnvValueDevelopment = "development"
    private let buildEnvValueStage = "stage"
    private let buildEnvValueProduction = "production"
    
    
    // MARK: Initilizer
    
    private init() {
        self.configureEnvironment()
    }
    
    /**
     Reads environment variables from info plist file and sets the current environment based on it
     */
    private func configureEnvironment() {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let trustbadgeEnvironmentValue = infoDictionary[self.environmentKey] as? String else  {
            self.currentEnvironment = .production
            return
        }
        self.setEnvironment(forValue: trustbadgeEnvironmentValue)
    }
    
    /**
     Sets the current environment based on the given info plist environment variable value
     */
    private func setEnvironment(forValue: String) {
        switch forValue {
        case self.buildEnvValueDevelopment: self.currentEnvironment = .development
        case self.buildEnvValueProduction: self.currentEnvironment = .production
        case self.buildEnvValueStage: self.currentEnvironment = .stage
        default: self.currentEnvironment = .production
        }
    }
}

// MARK: - Helper method for unit tests

extension TrustbadgeEnvironmentManager {
    func testSetEnvironment(forValue: String) {
        self.setEnvironment(forValue: forValue)
    }
}

/**
 TrustbadgeEnvironment enumeration defines different environments for the Trustbadge library
 */
enum TrustbadgeEnvironment {
    case development
    case stage
    case production
}
