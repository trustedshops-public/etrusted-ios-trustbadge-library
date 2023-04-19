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
    @Published var iconImageName: String?
    @Published var iconImage: UIImage?
    @Published var shouldShowExpendedStateContent: Bool = false
    
    var tsId: String
    var channelId: String?
    var productId: String?
    var context: TrustbadgeContext
    var alignment: TrustbadgeViewAlignment = .leading
    
    /**
     It validates, if valid inputs are provided as required for the widget to fetch data from backend and render
     the same in UI. For example, for `product grade` widget, both `channelId` and `productId` values are required.
     Whereas, `shop grade` and `buyer protection` widgets require just a valid channelId.
     */
    var areBadgeInputsValid: Bool {
        guard self.context != .trustMark else {
            // Checking validity of TS id
            guard !self.tsId.isEmpty else {
                TSConsoleLogger.log(
                    messege: "Error initializing trustbadge due to invalid TS id. Please see Trustylib library's readme for details about the required values.",
                    severity: .error
                )
                return false
            }
            return true
        }
     
        // Checking validity of channel id which is required for
        // shop grade, product grade and buyer protection widgets
        guard let channelId = self.channelId,
              !channelId.isEmpty else {
            TSConsoleLogger.log(
                messege: "Error initializing trustbadge due to invalid channel id. Please see Trustylib library's readme for details about the required values.",
                severity: .error
            )
            return false
        }
        
        // Checking validity of product id, if product grade widget has to be shown
        guard self.context == .productGrade else {
            // If the context is other then product grade, we can present the other
            // widgets with just a valid channel id.
            return true
        }
        
        // Checking validity of product id which is required for product grade widget
        guard let productId = self.productId,
              !productId.isEmpty else {
            TSConsoleLogger.log(
                messege: "Error initializing trustbadge due to invalid product id. Please see Trustylib library's readme for details about the required values.",
                severity: .error
            )
            return false
        }
        return true
    }
    
    // MARK: Private properties
    
    private var trustmarkDataService = TrustmarkDataService()
    
    // MARK: Initializer
    
    init(
        tsId: String,
        channelId: String? = nil,
        productId: String? = nil,
        context: TrustbadgeContext,
        alignment: TrustbadgeViewAlignment = .leading) {
            self.tsId = tsId
            self.channelId = channelId
            self.productId = productId
            self.context = context
            self.alignment = alignment
            self.iconImageName = TrustbadgeState.default(false).iconImageName
    }
    
    // MARK: Public methods
    
    /**
     Calls backend API to download trustbadge details for the given tsid
     */
    func getTrustmarkDetails(responseHandler: ResponseHandler<Bool>? = nil) {
        guard self.trustMarkDetails == nil else {
            responseHandler?(false)
            return
        }
        
        self.trustmarkDataService.getTrustmarkDetails(for: self.tsId) { [weak self] details in
            guard let strongSelf = self,
                  let tmDetails = details else {
                TSConsoleLogger.log(
                    messege: "Error loading trustmark details for shop with tsid: \(self?.tsId)",
                    severity: .error
                )
                responseHandler?(false)
                return
            }
            
            TSConsoleLogger.log(
                messege: "Successfully loaded trustmark details for shop with tsid: \(strongSelf.tsId)",
                severity: .info
            )
            
            strongSelf.trustMarkDetails = tmDetails
            strongSelf.isTrustmarkValid = tmDetails.trustMark.isValid
            strongSelf.currentState = TrustbadgeState.default(strongSelf.isTrustmarkValid)
            let validityString = strongSelf.isTrustmarkValid ? "is valid": "isn't valid!"
            
            TSConsoleLogger.log(
                messege: "Trustmark for shop with tsid: \(strongSelf.tsId) \(validityString)",
                severity: .info
            )
            
            strongSelf.setIconForState()
            responseHandler?(true)
        }
    }
    
    /**
     Sets icon name for the current state
     */
    func setIconForState() {
        if self.currentState == .default(self.isTrustmarkValid) {
            self.iconImageName = self.currentState.iconImageName
        } else if self.currentState == .expended, let imageName = self.context.iconImageName {
            self.iconImageName = imageName
        }

        guard let imageName = self.iconImageName,
              let imgPath = TrustbadgeResources.resourceBundle.path(
                forResource: imageName,
                ofType: ResourceExtension.png
              ),
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
