//
//  ProductCheckoutView.swift
//  Example
//
//  Created by Prem Pratap Singh on 25/11/22.
//

import SwiftUI
import Trustbadge

struct ProductCheckoutView: View {

    // MARK: Private properties

    @EnvironmentObject private var appContext: AppContext
    @EnvironmentObject private var shoppingCart: ShoppingCart

    @State private var isTrustbadgeVisible: Bool = true

    // MARK: User interface
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            Color.tsOffWhite
                .ignoresSafeArea()

            // Content view
            VStack(alignment: .leading, spacing: 10) {
                Text("Checkout")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    .padding(.top, 80)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(self.shoppingCart.checkoutItems, id: \.self.id) { item in
                            CheckoutItemView(checkoutItem: item)
                        }

                        Rectangle()
                            .fill(Color.tsGray300)
                            .frame(height: 1)
                            .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Subtotal")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.tsGray600)
                                Spacer()
                                Text("\(self.shoppingCart.subTotalAmount.formatted())")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.tsGray600)
                            }

                            HStack {
                                Text("Tax")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.tsGray600)
                                Spacer()
                                Text("\(ShoppingCart.taxAmount.formatted())")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.tsGray600)
                            }

                            HStack {
                                Text("Total")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.black)
                                Spacer()
                                Text("\(self.shoppingCart.totalAmount.formatted())")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color.black)
                            }
                        }
                        .padding(.top, 30)

                        // Go to payments button
                        Button(
                            action: {
                                print("Taking user to payments...")
                            },
                            label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.tsBlue700)
                                        .frame(height: 48)
                                    Text(NSLocalizedString("Go to payments (1 item)", comment: "Product details view: Add to cart title"))
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(Color.white)
                                }
                            }
                        )
                        .padding(.top, 40)

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
                    //print(value)
                    //let targetScrollOffset: CGFloat = 600
                    //self.isTrustbadgeVisible = value >= targetScrollOffset
                }

                Spacer()
            }
            .ignoresSafeArea()
            .padding(.horizontal, 16)

            // Trustbadge and it's container view
            VStack {
                Spacer()
                TrustbadgeView(
                    tsid: "X330A2E7D449E31E467D2F53A55DDD070",
                    channelId: "chl-b309535d-baa0-40df-a977-0b375379a3cc",
                    context: .buyerProtection
                )
                .frame(height: 75)
                .padding(.leading, 16)
                .padding(.bottom, 40)
                .opacity(self.isTrustbadgeVisible ? 1 : 0)
                .animation(.easeOut(duration: 0.3), value: self.isTrustbadgeVisible)
            }
        }

    }
}

struct CheckoutItemView: View {

    // MARK: Public properties

    var checkoutItem: CheckoutItem


    // MARK: User interface

    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 10) {
                Image(self.checkoutItem.product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 110)
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.checkoutItem.product.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.tsGray600)
                    Text(self.checkoutItem.product.shop.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.tsGray300)
                        .padding(.bottom, 10)

                    // Product quantity selection menu
                    Menu {
                        ForEach(1..<5) { quantity in
                            Button(
                                action: {
                                    self.checkoutItem.quantity = quantity
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
                                Text("\(self.checkoutItem.quantity)")
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

                Spacer()
                Text("\(self.checkoutItem.price.formatted())")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.black)
            }
            .padding(.all, 5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            )
        }
    }
}
