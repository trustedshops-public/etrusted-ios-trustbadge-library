//
//  Product.swift
//  Example
//
//  Created by Prem Pratap Singh on 29/11/22.
//

import Foundation

class Product {
    let id: String
    let image: String
    let landscapeImage: String?
    let name: String
    let description: String
    let price: Double
    let rating: Double
    let shop: Shop

    static let macbookProId: String = "tsprd001"

    init(
        id: String,
        image: String,
        landscapeImage: String? = nil,
        name: String,
        description: String,
        price: Double,
        rating: Double,
        shop: Shop
    ) {
        self.id = id
        self.image = image
        self.landscapeImage = landscapeImage
        self.name = name
        self.description = description
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
                    id: Product.macbookProId,
                    image: "appleMacbook",
                    landscapeImage: "appleMacbookLandscape",
                    name: "Macbook Pro (M1)",
                    description: "Protect your device from regular wear and tear by getting the Apple MacBook Pro 14. MacBook Pro was designed to minimize its impact on the environment. It’s free of harmful chemicals and materials. Now, you can use a single keyboard and mouse pad to work seamlessly between your iPad with universal control.",
                    price: 6500,
                    rating: 4.5,
                    shop: Shop.apple
                ),
                Product(
                    id: "tsprd002",
                    image: "samsungLaptop",
                    name: "Samsung galaxy book2 (16 inch)",
                    description: "",
                    price: 4500,
                    rating: 3.5,
                    shop: Shop.samsung
                )
            ],
            [
                Product(
                    id: "tsprd003",
                    image: "sonyLaptop",
                    name: "Sony vio",
                    description: "",
                    price: 4200,
                    rating: 3.0,
                    shop: Shop.sony
                ),
                Product(
                    id: "tsprd004",
                    image: "appleMacbookAir",
                    name: "Apple macbook air",
                    description: "",
                    price: 3800,
                    rating: 4.5,
                    shop: Shop.apple
                )
            ],
            [
                Product(
                    id: "tsprd005",
                    image: "appleMacbook",
                    name: "Macbook Pro (M2)",
                    description: "",
                    price: 10500,
                    rating: 4.0,
                    shop: Shop.apple
                ),
                Product(
                    id: "tsprd006",
                    image: "samsungLaptop",
                    name: "Samsung galaxy book2 (13 inch)",
                    description: "",
                    price: 3500,
                    rating: 3.0,
                    shop: Shop.samsung
                )
            ]
        ]
    }
}
