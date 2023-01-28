//
//  HomeView.swift
//  Example
//
//  Created by Prem Pratap Singh on 07/11/22.
//

import SwiftUI
import Trustylib

struct HomeView: View {

    // MARK: Private properties

    @EnvironmentObject private var appContext: AppContext
    
    @State private var productCategoryWidgetWidth: CGFloat = 0
    @State private var isTrustbadgeVisible: Bool = true

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
                                    .onTapGesture {
                                        self.showProductsForTheCategory(productCategory)
                                    }
                                }
                            }
                        }

                        GeometryReader { proxy in
                            let offset = proxy.frame(in: .named("scroll")).minY
                            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                        }
                    }
                    .padding(.bottom, 140)
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    let targetScrollOffset: CGFloat = 1100
                    self.isTrustbadgeVisible = value >= targetScrollOffset
                }
            }
            .padding(.horizontal, 16)

            // Trustbadge and it's container view
            VStack {
                Spacer()
                TrustbadgeView(
                    tsid: "X330A2E7D449E31E467D2F53A55DDD070",
                    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
                    context: .shopGrade
                )
                .frame(height: 75)
                .opacity(self.isTrustbadgeVisible ? 1 : 0)
                .animation(.easeOut(duration: 0.3), value: self.isTrustbadgeVisible)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 120)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            self.productCategoryWidgetWidth = (UIScreen.main.bounds.width - 2*self.horizontalPadding - self.productCategoryWidgetSpacing) * 0.5
        }
    }

    // MARK: Private methods

    /**
     Switches view to products list view and shows products for the selected product category
     */
    private func showProductsForTheCategory(_ category: ProductCategory) {
        self.appContext.selectedProductCategory = category
        self.appContext.selectedMainTab = 1
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

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
