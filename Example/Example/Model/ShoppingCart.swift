//
//  ShoppingCart.swift
//  Example
//
//  Created by Prem Pratap Singh on 30/11/22.
//

import Foundation

class ShoppingCart: ObservableObject, Identifiable {
    let id: String = UUID().uuidString
    static let taxAmount: Double = 50
    var checkoutItems: [CheckoutItem]

    var subTotalAmount: Double {
        var amount: Double = 0
        for item in self.checkoutItems {
            amount += item.price
        }
        return amount
    }

    var totalAmount: Double {
        return self.subTotalAmount + ShoppingCart.taxAmount
    }

    init(checkoutItems: [CheckoutItem]) {
        self.checkoutItems = checkoutItems
    }

    func addItem(_ item: CheckoutItem) {
        self.checkoutItems.append(item)
    }
}

class CheckoutItem: Identifiable {
    let id: String = UUID().uuidString
    let product: Product
    var quantity: Int

    var price: Double {
        let productPrice = self.product.price * Double(self.quantity)
        return productPrice
    }

    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}
