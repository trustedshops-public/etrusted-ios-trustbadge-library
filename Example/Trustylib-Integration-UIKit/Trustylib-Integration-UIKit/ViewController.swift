//
//  ViewController.swift
//  Trustylib-Integration-UIKit
//
//  Created by Prem Pratap Singh on 01/02/23.
//

import UIKit
import SwiftUI
import Trustylib

class ViewController: UIViewController {

    private lazy var trustbadgeView: UIHostingController = {
        let trustbadge = TrustbadgeView(
            tsid: "X330A2E7D449E31E467D2F53A55DDD070",
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

