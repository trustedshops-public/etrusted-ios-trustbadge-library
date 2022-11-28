//
//  ProductCategory.swift
//  Example
//
//  Created by Prem Pratap Singh on 28/11/22.
//

import Foundation

/**
 ProductCategory data object contains details about product categories
 like Shoes, Pets, Groceries, etc
 */
class ProductCategory {

    // MARK: Public properties
    let id: String = UUID().uuidString
    let title: String
    let icon: String

    // MARK: Initializer
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}

extension ProductCategory {

    /*
     Returns list of test product categories
     */
    static var testCategories: [[ProductCategory]] {
        return [
            [
                ProductCategory(title: "Car, motorbikes and Accessories", icon: "carAndMotorbikes"),
                ProductCategory(title: "Floristry & Gardening", icon: "floristryAndGardening")
            ],
            [
                ProductCategory(title: "Pet supplies", icon: "petSupplies"),
                ProductCategory(title: "Luggage, bags and leather goods", icon: "luggageBagsAndLeatherGoods")
            ],
            [
                ProductCategory(title: "Shoes", icon: "shoes"),
                ProductCategory(title: "Photo, print & book-on-demand", icon: "photoPrintAndBooks")
            ],
            [
                ProductCategory(title: "Pharmacy products", icon: "pharmacyProducts"),
                ProductCategory(title: "Sport equipments", icon: "sportEquipments")
            ],
            [
                ProductCategory(title: "Groceries", icon: "groceries"),
                ProductCategory(title: "Cosmetics", icon: "cosmetics")
            ]
        ]
    }
}
