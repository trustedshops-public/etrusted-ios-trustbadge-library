//
//  Image + Bundle.swift
//  Trustylib
//
//  Created by Prem Pratap Singh on 11/11/22.
//

import SwiftUI

extension Image {
    init(imageName: String) {
        self.init(imageName, bundle: Bundle(identifier:"com.etrusted.ios.trustylib"))
    }
}
