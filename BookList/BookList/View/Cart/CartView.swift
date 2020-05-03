//
//  CartView.swift
//  BookList
//
//  Created by Serafín Ennes Moscoso on 23/04/2020.
//  Copyright © 2020 Serafín Ennes Moscoso. All rights reserved.
//

import SwiftUI

struct CartState {
    var cart: Cart
}

enum CartInput {
    case checkout
}

struct CartView: View {

    @ObservedObject
    var viewModel: AnyViewModel<CartState, CartInput>

    init(service: BookService) {
        self.viewModel = AnyViewModel(CartViewModel(service: service))
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                // Dismiss button
                HStack() {
                    Image("iconClose")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(20)

                    Spacer()
                }

                // Title
                VStack {
                    Text("Your bag")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                    Text(String(viewModel.state.cart.numberOfItems) + " items")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }

                // Item list
                VStack(alignment: .leading) {
                    ForEach(viewModel.state.cart.items) { item in
                        CartRow(item: item)
                    }
                }

                Spacer().frame(height: 20)

                // Summary
                HStack {
                    VStack {
                        Image("shipping")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.bottom, -8)
                        Text("FREE")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                    }.frame(width: 64, height: 64)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(15)

                    Spacer().frame(width: 40)

                    VStack(alignment: .leading) {
                        Text("Total:")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                        Text("$" + String(viewModel.state.cart.total))
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                    }

                    Spacer().frame(width: 80)
                }

                // Checkout button
                Divider().padding()

                Button(action: checkout) {
                    HStack {
                        Text("Checkout")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                    }
                    .frame(width: 200)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(40)
                }
            }
        }
    }
}

private extension CartView {
    func checkout() {
        viewModel.trigger(.checkout)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(service: MockBookService())
    }
}
