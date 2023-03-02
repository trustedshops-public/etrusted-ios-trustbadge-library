//
//  TrustbadgeViewWrapperTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
import SwiftUI
@testable import Trustylib

final class TrustbadgeViewWrapperTests: XCTestCase {

    func testTrustbadgeViewWrapperInstantiatesValidTrustbadgeView() throws {
        let trustbadgeView = TrustbadgeViewWrapper.createTrustbadgeView(
            tsid: "X330A2E7D449E31E467D2F53A55DDD070",
            channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
            context: .trustMark
        )
        
        print(trustbadgeView)
        XCTAssertNotNil(
            trustbadgeView,
            "TrustbadgeViewWrapper should instantiate a valid trustbadge view"
        )
    }
}
