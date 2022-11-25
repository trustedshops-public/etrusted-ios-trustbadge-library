//
//  AppContext.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import Foundation

/**
 AppContext is contains application level of data across views
 */
class AppContext: ObservableObject {
    @Published var selectedMainTab: Int = 0
}
