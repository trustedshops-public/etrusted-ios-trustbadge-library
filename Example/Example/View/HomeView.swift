//
//  HomeView.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI
import Trustbadge

struct HomeView: View {

    // MARK: Private properties

    @State private var productCategoryWidgetWidth: CGFloat = 0
    private var productCategoryWidgetSpacing: CGFloat = 12
    private var horizontalPadding: CGFloat = 16

    // MARK: User interface

    var body: some View {
        ZStack {

            // Background
            Color.tsOffWhite
                .ignoresSafeArea()

            // Content view
            VStack {
                Text("Explore")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    .padding(.top, 80)

                // Search field
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.tsGray600, lineWidth: 1)
                        .background(Color.white)
                    HStack(spacing: 10) {
                        Image("searchIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Search")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color.tsGray600)
                    }
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                }
                .frame(height: 40)

                // Product categories section
                HStack {
                    Text("Your categories")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("Show all")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.blue)
                }
                .padding(.top, 20)

                // Product categories
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: self.productCategoryWidgetSpacing) {
                        ForEach(0..<ProductCategory.testCategories.count) { i in
                            let productCategories: [ProductCategory] = ProductCategory.testCategories[i]
                            HStack(alignment: .top, spacing: self.productCategoryWidgetSpacing) {
                                ForEach(0..<productCategories.count) { j in
                                    let productCategory = productCategories[j]
                                    ProductCategoryDetailsView(
                                        productCategory: productCategory,
                                        width: self.productCategoryWidgetWidth
                                    )
                                }
                            }
                        }
                    }
                    .padding(.bottom, 140)
                }
            }
            .padding(.horizontal, 16)

            // Trustbadge and it's container view
            VStack {
                Spacer()
                TrustbadgeView(tsid: "X330A2E7D449E31E467D2F53A55DDD070", context: .shopGrade)
                    .frame(width: 100, height: 100)
            }
            .padding(.bottom, 110)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            self.productCategoryWidgetWidth = (UIScreen.main.bounds.width - 2*self.horizontalPadding - self.productCategoryWidgetSpacing) * 0.5
        }
    }
}

/**
 ProductCategoryView shows details about a product category like icon, name, etc
 */
struct ProductCategoryDetailsView: View {

    // MARK: Public properties

    var productCategory: ProductCategory
    var width: CGFloat

    // MARK: User interface

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(self.productCategory.icon)
                .resizable()
                .scaledToFit()
            Text(self.productCategory.title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.black)
                .padding(.leading, 10)
                .frame(height: 40, alignment: .top)
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        }
    }
}