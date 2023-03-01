//
//  TrustbadgeViewTests.swift
//  TrustylibTests
//
//  Created by Prem Pratap Singh on 28/02/23.
//

import XCTest
import SwiftUI
@testable import Trustylib

/**
 This test suite tests `TrustbadgeView`'s initialization workflow and the UI structure
 */
final class TrustbadgeViewTests: XCTestCase {
    let tsid = "X330A2E7D449E31E467D2F53A55DDD070"
    let channelId = "chl-b309535d-baa0-40df-a977-0b375379a3cc"
    let context: TrustbadgeContext = .shopGrade
    
    func testTrustbadgeViewInitializesWithCorrectValues() throws {
        let trustbadgeView = TrustbadgeView(
            tsid: self.tsid,
            channelId: self.channelId,
            context: self.context)
        
        XCTAssert(
            trustbadgeView.trustedShopId == self.tsid,
            "TrustbadgeView should set correct tsid during initialization"
        )
        
        XCTAssert(
            trustbadgeView.currentChannelId == self.channelId,
            "TrustbadgeView should set correct channel id during initialization"
        )
        
        XCTAssert(
            trustbadgeView.currentContext == self.context,
            "TrustbadgeView should set correct context during initialization"
        )
        
        XCTAssertNotNil(
            trustbadgeView.currentViewModel,
            "TrustbadgeView should initialize view model during initialization"
        )
    }
    
    func testTrustbadgeViewBodyIsNotNil() {
        let trustbadgeView = TrustbadgeView(
            tsid: self.tsid,
            channelId: self.channelId,
            context: self.context)
        XCTAssertNotNil(
            trustbadgeView.body,
            "TrustbadgeView body value should not be nil"
        )
    }
}
