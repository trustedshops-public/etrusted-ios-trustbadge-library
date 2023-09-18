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
 TrustcardBorderGraphics draws Trustcard's graphics for border line and the wave at bottom right corner.
 */
struct TrustcardBorderGraphics: View {
    
    // MARK: - Private properties
    
    @State private var bannerImage: UIImage?
    
    // MARK: - User interface
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 8).stroke(Color.tsPineapple500, lineWidth: 6).frame(maxWidth: .infinity, maxHeight: .infinity)
            if let image = self.bannerImage { Image(uiImage: image).resizable().scaledToFit().frame(height: 75) }
        }
        .onAppear { self.loadBannerImage(name: "trustcardBanner") }
    }
    
    // MARK: - Private methods
    
    /**
     Loads bottom right banner image from resource bundle
     */
    private func loadBannerImage(name: String, completionHandler: ResponseHandler<Bool>? = nil) {
        guard let imgPath = TrustbadgeResources.resourceBundle.path( forResource: name, ofType: ResourceExtension.png),
              let image = UIImage(contentsOfFile: imgPath) else {
            completionHandler?(false)
            return
        }
        self.bannerImage = image
        completionHandler?(true)
    }
}

// MARK: Unit tests helper methods

extension TrustcardBorderGraphics {
    func loadBannerGraphics(name: String, completionHandler: ResponseHandler<Bool>? = nil) {
        self.loadBannerImage(name: name, completionHandler: completionHandler)
    }
}
