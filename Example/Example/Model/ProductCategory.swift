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
    let id: String
    let title: String
    let icon: String
    let products: [[Product]]

    // MARK: Initializer
    init(id: String, title: String, icon: String, products: [[Product]]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.products = products
    }
}

extension ProductCategory {

    /*
     Returns list of test product categories
     */
    static var testCategories: [[ProductCategory]] {
        return [
            [
                ProductCategory(
                    id: "tspcat001",
                    title: "Electronics",
                    icon: "electronics",
                    products: Product.testElectronicsProducts
                ),
                ProductCategory(
                    id: "tspcat002",
                    title: "Clothing",
                    icon: "clothing",
                    products: []
                )
            ],
            [
                ProductCategory(
                    id: "tspcat003",
                    title: "Groceries",
                    icon: "groceries",
                    products: []
                ),
                ProductCategory(
                    id: "tspcat004",
                    title: "Cosmetics",
                    icon: "cosmetics",
                    products: []
                )
            ],
            [
                ProductCategory(
                    id: "tspcat005",
                    title: "Shoes",
                    icon: "shoes",
                    products: []
                ),
                ProductCategory(
                    id: "tspcat006",
                    title: "Pet supplies",
                    icon: "petSupplies",
                    products: []
                )
            ],
            [
                ProductCategory(
                    id: "tspcat007",
                    title: "Pharmacy products",
                    icon: "pharmacyProducts",
                    products: []
                ),
                ProductCategory(
                    id: "tspcat008",
                    title: "Sport equipments",
                    icon: "sportEquipments",
                    products: []
                )
            ],
            [
                ProductCategory(
                    id: "tspcat009",
                    title: "Car, motorbikes and Accessories",
                    icon: "carAndMotorbikes",
                    products: []
                ),
                ProductCategory(
                    id: "tspcat0010",
                    title: "Floristry & Gardening",
                    icon: "floristryAndGardening",
                    products: []
                )
            ],
            [
                ProductCategory(
                    id: "tspcat0011",
                    title: "Luggage, bags and leather goods",
                    icon: "luggageBagsAndLeatherGoods",
                    products: []
                ),
                ProductCategory(
                    id: "tspcat0012",
                    title: "Photo, print & book-on-demand",
                    icon: "photoPrintAndBooks",
                    products: []
                )
            ]
        ]
    }
}
