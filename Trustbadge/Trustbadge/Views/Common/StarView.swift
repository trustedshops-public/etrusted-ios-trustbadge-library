//
//  StarView.swift
//  Trustbadge
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import Foundation
import SwiftUI

/**
 Custom shape view for drawing star with required corners and edge smoothness
 */
struct StarView: Shape {

    // MARK: Public properties
    
    let corners: Int
    let smoothness: Double

    // MARK: Lifecycle methods

    /// Draws path for the star shape based on corners and smoothness parameters
    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }

        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)

        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        var bottomEdge: Double = 0

        for corner in 0..<corners * 2  {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            currentAngle += angleAdjustment
        }

        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}
