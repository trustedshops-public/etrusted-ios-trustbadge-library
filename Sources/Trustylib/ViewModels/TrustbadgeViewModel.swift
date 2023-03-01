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
//  Created by Prem Pratap Singh on 27/02/23.
//

import Foundation
import SwiftUI

/**
 TrustbadgeViewModel serves TrustbadgeView for managing view states and
 getting trustmark details for the given TSID.
 */
class TrustbadgeViewModel: ObservableObject {
    
    // MARK: Public properties
    
    @Published var trustMarkDetails: TrustmarkDetailsModel?
    @Published var isTrustmarkValid: Bool = false
    @Published var currentState: TrustbadgeState = .default(false)
    @Published var iconImageName: String = TrustbadgeState.default(false).iconImageName
    @Published var iconImage: UIImage?
    @Published var shouldShowExpendedStateContent: Bool = false
    
    // MARK: Private properties
    
    private var trustmarkDataService = TrustmarkDataService()
    private var context: TrustbadgeContext
    
    // MARK: Initializer
    
    init(context: TrustbadgeContext) {
        self.context = context
    }
    
    // MARK: Public methods
    
    /**
     Calls backend API to download trustbadge details for the given tsid
     */
    func getTrustmarkDetails(for tsid: String, responseHandler: ResponseHandler<Bool>? = nil) {
        guard self.trustMarkDetails == nil else {
            responseHandler?(false)
            return
        }
        
        self.trustmarkDataService.getTrustmarkDetails(for: tsid) { details in
            guard let tmDetails = details else {
                TSConsoleLogger.log(
                    messege: "Error loading trustmark details for shop with tsid: \(tsid)",
                    severity: .error
                )
                responseHandler?(false)
                return
            }
            
            TSConsoleLogger.log(
                messege: "Successfully loaded trustmark details for shop with tsid: \(tsid)",
                severity: .info
            )
            
            self.trustMarkDetails = tmDetails
            self.isTrustmarkValid = tmDetails.trustMark.isValid
            self.currentState = TrustbadgeState.default(self.isTrustmarkValid)
            let validityString = self.isTrustmarkValid ? "is valid": "isn't valid!"
            
            TSConsoleLogger.log(
                messege: "Trustmark for shop with tsid: \(tsid) \(validityString)",
                severity: .info
            )
            
            self.setIconForState()
            responseHandler?(true)
        }
    }
    
    /**
     Sets icon name for the current state
     */
    func setIconForState() {
        if self.currentState == .default(self.isTrustmarkValid) {
            self.iconImageName = self.currentState.iconImageName
        } else if self.currentState == .expended {
            self.iconImageName = self.context.iconImageName
        }

        guard let imgPath = TrustbadgeResources.resourceBundle.path(forResource: self.iconImageName,
                                                                    ofType: ResourceExtension.png),
              let image = UIImage(contentsOfFile: imgPath) else {
            return
        }
        self.iconImage = image
    }
    
    /**
     Animates trustbadge UI components to show a subtle experience
     It first animates the expended background view. When the background view animation is completed,
     it then sets the visibility flag on for the expended view content like shop grade, product grade, etc
     */
    func expandBadgeToShowDetails() {
        guard self.context != .trustMark else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            self.shouldShowExpendedStateContent = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentState = .expended
            self.setIconForState()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.shouldShowExpendedStateContent = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                self.currentState = .default(self.isTrustmarkValid)
                self.setIconForState()
            }
        }
    }
}

// MARK: Helper properties/methods for tests

extension TrustbadgeViewModel {
    var activeContext: TrustbadgeContext {
        return self.context
    }
}
