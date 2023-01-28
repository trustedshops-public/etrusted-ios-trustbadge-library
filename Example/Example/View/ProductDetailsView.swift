//
//  ProductDetailsView.swift
//  Example
//
//  Created by Prem Pratap Singh on 29/11/22.
//

import SwiftUI
import Trustylib

struct ProductDetailsView: View {

    // MARK: Public properties

    var productDetails: Product

    // MARK: Private properties

    @EnvironmentObject private var appContext: AppContext
    @EnvironmentObject private var shoppingCart: ShoppingCart

    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedQuantity: Int = 1

    /**
     Returns product image based on its availability
     */
    private var productImageName: String {
        if let landscapeImage = self.productDetails.landscapeImage {
            return landscapeImage
        }
        return self.productDetails.image
    }

    // MARK: User interface
    
    var body: some View {
        ZStack {
            // Background
            Color.tsOffWhite
                .ignoresSafeArea()

            // Content view
            VStack(alignment: .leading, spacing: 20) {
                // Product image
                ZStack(alignment: .topLeading) {
                    Image(self.productImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)

                    // Back button
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 40, height: 40)
                                Image("leftArrowIcon")
                                    .renderingMode(.template)
                                    .resizable()
                                    .tint(Color.white)
                                    .scaledToFit()
                                    .frame(width: 9, height: 16)
                            }
                        }
                    )
                    .offset(x: 5, y: 10)
                }

                // Product details
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(self.productDetails.shop.name)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color.tsGray600)

                        Text("\(self.productDetails.name)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.black)

                        Text("\(self.productDetails.description)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color.tsGray600)
                            .padding(.top, 10)

                        HStack {
                            Spacer()

                            // Product quantity selection menu
                            Text("Quantity:")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color.black)
                            Menu {
                                ForEach(1..<5) { quantity in
                                    Button(
                                        action: {
                                            self.selectedQuantity = quantity
                                        },
                                        label: {
                                            Text("\(quantity)")
                                        }
                                    )
                                }
                            }
                            label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.tsGray100)
                                        .frame(width: 50, height: 30)
                                    HStack(alignment: .center) {
                                        Text("\(self.selectedQuantity)")
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundColor(Color.black)
                                        Image("downArrow")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 13, height: 7)
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)

                        // Add to cart button
                        Button(
                            action: {
                                self.addProductToShoppingCart()
                            },
                            label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.tsBlue700)
                                        .frame(height: 48)
                                    HStack {
                                        Image("checkoutTabIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .tint(Color.white)
                                            .frame(width: 24, height: 24)
                                        Text(NSLocalizedString("Add to cart", comment: "Product details view: Add to cart title"))
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }
                        )
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 140)
                }
            }
            .padding(.top, 60)
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }

    // MARK: Private methods

    /**
     Creates a checkout product item based on the selected product and add it to the
     global shoppig cart object
     */
    private func addProductToShoppingCart() {
        let checkoutItem = CheckoutItem(product: self.productDetails, quantity: self.selectedQuantity)
        self.shoppingCart.addItem(checkoutItem)

        self.appContext.selectedMainTab = 2
    }
}
