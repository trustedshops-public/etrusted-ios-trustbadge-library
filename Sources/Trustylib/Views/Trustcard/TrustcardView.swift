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
 TrustcardView presents UI/UX showing details about the buyer protection support and
 action buttons for subscribing to buyer protection, upgrading to plus protection and
 other buyer protection related workflows.
 */
struct TrustcardView: View {
    
    // MARK: - Public properties
    
    var orderDetails: OrderDetailsModel?
    var state: TrustcardState?
    
    // MARK: - User interface
    
    var body: some View {
        ZStack {
            
            // Buyer protection content view
            VStack(alignment: .leading, spacing: 16) {
                Rectangle()
                    .fill(Color.tsGray100)
                    .frame(height: 150)
                
                Text("We may ask for further review information by e-mail to help other online shoppers. Terms and Conditions & Privacy Policy")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.tsGray800)
                
                Rectangle()
                    .fill(Color.tsGray100)
                    .frame(height: 200)
            }
            .padding(.all, 16)
            
            // Border graphics
            TrustcardBorderGraphics()
        }
        .background(Color.white)
    }
}
