//
//  TrustbadgeImage.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 11/11/22.
//

import SwiftUI

/**
 TrustbadgeImage loads image assets from the library's bundle to make sure the images
 are loaded properly.

 Specifying library's bundle id in the image constructor is required else the iOS system will
 attempt to load image from the host app and would fail.
 */
struct TrustbadgeImage: View {

    // MARK: Public properties

    var assetName: String
    var width: CGFloat
    var height: CGFloat

    // MARK: User interface
    
    var body: some View {
        Image(self.assetName,
              bundle: Bundle(identifier:"com.etrusted.ios.trustbadge")
        )
        .resizable()
        //.scaledToFit()
        .frame(width: self.width, height: self.height)
    }
}
