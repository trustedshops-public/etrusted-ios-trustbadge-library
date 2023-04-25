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
//  Created by Prem Pratap Singh on 01/02/23.
//

import UIKit
import SwiftUI
import Trustylib

class ViewController: UIViewController {

    private lazy var trustbadgeView: UIHostingController = {
        let trustbadge = TrustbadgeView(
            tsId: "X330A2E7D449E31E467D2F53A55DDD070",
            channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
            context: .shopGrade
        )
        return UIHostingController(rootView: trustbadge)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTrustbadgeView()
    }

    private func addTrustbadgeView() {
        self.addChild(self.trustbadgeView)
        self.view.addSubview(self.trustbadgeView.view)

        /// Setup the constraints to update the SwiftUI view boundaries.
        self.trustbadgeView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.trustbadgeView.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.trustbadgeView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.trustbadgeView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.trustbadgeView.view.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}

