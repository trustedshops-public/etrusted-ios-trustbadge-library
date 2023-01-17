//
//  Shop.swift
//  Example
//
//  Created by Prem Pratap Singh on 29/11/22.
//

import Foundation

class Shop {
    let id: String = UUID().uuidString
    let name: String

    init(name: String) {
        self.name = name
    }
}

extension Shop {
    static var apple: Shop {
        return Shop(name: "Apple")
    }

    static var samsung: Shop {
        return Shop(name: "Samsung")
    }

    static var sony: Shop {
        return Shop(name: "Sony")
    }
}
