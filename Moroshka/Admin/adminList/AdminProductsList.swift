//
//  AdminProductsList.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 25.08.2023.
//

import SwiftUI

struct AdminProductsList: View {
   
    @StateObject var viewModel = AdminProductListViewModel()
    @State var isShowAddProduct = false
    
    var body: some View {
        VStack{
            Button {
                isShowAddProduct.toggle()
            } label: {
                Text("Добавить товар")
            }.padding()

            List{
                ForEach(viewModel.productsArray, id: \.id){ product in
                adminProductCell(product: product)
                        .swipeActions(content: {
                            Button(action: {
                                viewModel.productsArray.removeAll { position in
                                    position.id == product.id
                                }
                                viewModel.deleteProduct(product: product)
                            }, label: {
                                Text("Удалить")
                            })
                        }).tint(.red)
                }
            }
            .onAppear(){
                viewModel.getProducts()
            }
        }
        .sheet(isPresented: $isShowAddProduct) {
            AddProductView()
        }
    }
        
}

