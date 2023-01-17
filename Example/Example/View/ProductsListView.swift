//
//  ProductsView.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI
import Trustbadge

struct ProductsListView: View {

    // MARK: Private properties

    @EnvironmentObject private var appContext: AppContext

    @State private var productWidgetWidth: CGFloat = 0
    @State private var isTrustbadgeVisible: Bool = true
    @State private var selectedProduct: Product?
    @State private var shouldShowProductDetails: Bool = false

    private var productWidgetSpacing: CGFloat = 12
    private var horizontalPadding: CGFloat = 16

    // MARK: User interface

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.tsOffWhite
                    .ignoresSafeArea()

                // Content view
                VStack {

                    // Title text
                    Text("\(self.appContext.selectedProductCategory?.title ?? "Products")")
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
                    if let selectedProductCategory = self.appContext.selectedProductCategory {
                        VStack(alignment: .leading) {
                            Text("Available \(selectedProductCategory.products.count * 2) products")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color.tsGray600)
                            Rectangle()
                                .fill(Color.tsGray200)
                                .frame(height: 1)
                        }
                        .padding(.top, 20)

                        if !selectedProductCategory.products.isEmpty {
                            // Products list
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: self.productWidgetSpacing) {
                                    ForEach(0..<selectedProductCategory.products.count) { i in
                                        let products: [Product] = selectedProductCategory.products[i]
                                        HStack(alignment: .top, spacing: self.productWidgetSpacing) {
                                            ForEach(0..<products.count) { j in
                                                let product = products[j]
                                                ProductWidgetView(
                                                    product: product,
                                                    width: self.productWidgetWidth
                                                )
                                                .onTapGesture {
                                                    self.showDetailsForProduct(product)
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
                        } else {
                            Spacer()
                        }
                    } else {
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)

                // Trustbadge and it's container view
                VStack {
                    Spacer()
                    TrustbadgeView(
                        tsid: "X330A2E7D449E31E467D2F53A55DDD070",
                        channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
                        context: .trustMark
                    )
                    .frame(height: 75)
                    .opacity(self.isTrustbadgeVisible ? 1 : 0)
                    .animation(.easeOut(duration: 0.3), value: self.isTrustbadgeVisible)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 120)

                // Link to product details view
                if let product = self.selectedProduct {
                    NavigationLink(
                        destination: ProductDetailsView(
                            productDetails: product
                        ),
                        isActive: self.$shouldShowProductDetails) {
                            EmptyView()
                        }
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all)
            .onAppear {
                self.productWidgetWidth = (UIScreen.main.bounds.width - 2*self.horizontalPadding - self.productWidgetSpacing) * 0.5
            }
            .onChange(of: self.appContext.selectedMainTab) { tabIndex in
                self.selectedProduct = nil
                self.shouldShowProductDetails = false
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: Private methods

    /**
     Presents product details view to show details about the selected product
     */
    private func showDetailsForProduct(_ product: Product) {
        //For the demo purpose, we show product details only for Apple macbook pro
        guard product.id == Product.macbookProId else { return }

        self.selectedProduct = product
        self.shouldShowProductDetails = true
    }
}

/**
 ProductDetailsView shows details about a product like icon, name, price, brand etc
 */
struct ProductWidgetView: View {

    // MARK: Public properties

    var product: Product
    var width: CGFloat

    // MARK: User interface

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(self.product.image)
                .resizable()
                .scaledToFit()
            Text(self.product.name)
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
