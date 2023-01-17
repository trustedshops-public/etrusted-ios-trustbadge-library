//
//  OverlayContainerContext.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import Foundation

/**
 OverlayContainerContext contains overlays (progress indicator, alert views, etc) related configurations
 */
class OverlayContainerContext: ObservableObject {
    @Published var shouldShowProgressIndicator = false
}
