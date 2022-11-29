//
//  ProductsView.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI
import Trustbadge

struct ProductsListView: View {

    @EnvironmentObject private var appContext: AppContext

    @State private var productWidgetWidth: CGFloat = 0
    @State private var isTrustbadgeVisible: Bool = true

    private var productWidgetSpacing: CGFloat = 12
    private var horizontalPadding: CGFloat = 16

    var body: some View {
        ZStack {
            // Background
            Color.tsOffWhite
                .ignoresSafeArea()

            // Content view
            VStack {

                // Title text
                Text("Products")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(.top, 80)

                // Toolbar
                HStack(alignment: .center) {
                    Image("gridLayoutIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Spacer()
                    Image("sortButtonIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    Spacer()
                    Image("filterButtonIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
                .padding(.top, 20)

                // Product categories section
                VStack(alignment: .leading) {
                    Text("Available \(Product.testElectronicsProducts.count * 2) products")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.tsGray600)
                    Rectangle()
                        .fill(Color.tsGray300)
                        .frame(height: 1)
                }
                .padding(.top, 20)


                // Product categories
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: self.productWidgetSpacing) {
                        ForEach(0..<Product.testElectronicsProducts.count) { i in
                            let products: [Product] = Product.testElectronicsProducts[i]
                            HStack(alignment: .top, spacing: self.productWidgetSpacing) {
                                ForEach(0..<products.count) { j in
                                    let product = products[j]
                                    ProductDetailsView(
                                        product: product,
                                        width: self.productWidgetWidth
                                    )
                                    .onTapGesture {
                                        //self.showProductsForTheCategory(productCategory)
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
                .padding(.top, 20)
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    let targetScrollOffset: CGFloat = 750
                    self.isTrustbadgeVisible = value >= targetScrollOffset
                }
            }
            .padding(.horizontal, 16)

            // Trustbadge and it's container view
            VStack {
                Spacer()
                TrustbadgeView(tsid: "X330A2E7D449E31E467D2F53A55DDD070", context: .productGrade)
                    .frame(width: 100, height: 100)
                    .opacity(self.isTrustbadgeVisible ? 1 : 0)
                    .animation(.easeOut(duration: 0.3))
            }
            .padding(.bottom, 110)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            self.productWidgetWidth = (UIScreen.main.bounds.width - 2*self.horizontalPadding - self.productWidgetSpacing) * 0.5
        }
    }
}

/**
 ProductDetailsView shows details about a product like icon, name, price, brand etc
 */
struct ProductDetailsView: View {

    // MARK: Public properties

    var product: Product
    var width: CGFloat

    // MARK: User interface

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(self.product.icon)
                .resizable()
                .scaledToFit()
            Text(self.product.title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.black)
                .padding(.leading, 10)
                .frame(height: 40, alignment: .top)

            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center, spacing: 0) {
                    Text("Sold by: ")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.tsGray600)
                    Text("\(self.product.shop.name)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.blue)
                }

                StarRatingView(rating: Float(self.product.rating))

                Text("\(self.product.price.formatted()) €")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color.black)


            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        }
    }
}
