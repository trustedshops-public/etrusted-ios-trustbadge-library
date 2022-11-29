//
//  Product.swift
//  Example
//
//  Created by Prem Pratap Singh on 29/11/22.
//

import Foundation

class Product {
    let id: String = UUID().uuidString
    let icon: String
    let title: String
    let price: Double
    let rating: Double
    let shop: Shop

    init(icon: String, title: String, price: Double, rating: Double, shop: Shop) {
        self.icon = icon
        self.title = title
        self.price = price
        self.rating = rating
        self.shop = shop
    }
}

extension Product {
    static var testElectronicsProducts: [[Product]] {
        return [
            [
                Product(
                    icon: "appleMacbook",
                    title: "Macbook Pro (M1)",
                    price: 6500,
                    rating: 4.5,
                    shop: Shop.apple
                ),
                Product(
                    icon: "samsungLaptop",
                    title: "Samsung galaxy book2 (16 inch)",
                    price: 4500,
                    rating: 3.5,
                    shop: Shop.samsung
                )
            ],
            [
                Product(
                    icon: "sonyLaptop",
                    title: "Sony vio",
                    price: 4200,
                    rating: 4.0,
                    shop: Shop.sony
                ),
                Product(
                    icon: "appleMacbookAir",
                    title: "Apple macbook air",
                    price: 3800,
                    rating: 4.5,
                    shop: Shop.apple
                )
            ],
            [
                Product(
                    icon: "appleMacbook",
                    title: "Macbook Pro (M2)",
                    price: 10500,
                    rating: 5.0,
                    shop: Shop.apple
                ),
                Product(
                    icon: "samsungLaptop",
                    title: "Samsung galaxy book2 (13 inch)",
                    price: 3500,
                    rating: 4.0,
                    shop: Shop.samsung
                )
            ]
        ]
    }
}
