//
//  AdminView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 21.08.2023.
//

import SwiftUI

struct AdminView: View {
    
    @StateObject var viewModel = AdminViewModel()
    @State var isOrderViewShow = false
    @State var isShowAuthView = false
    @State var isShowAddProduct = false
    
    
    var body: some View {
        VStack{
            
            HStack {
                Button {
                    AuthService.shared.signOut()
                    isShowAuthView.toggle()
                } label: {
                    Text("Выход")
                }
                Button {
                    isShowAddProduct.toggle()
                } label: {
                    Text("Редактор асортимента")
                }
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Обновить")
                }
            }
            List {
                ForEach(viewModel.orders, id:\.id) { order in
                    OrderCell(order: order)
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }.listStyle(.plain)
            }
        }
        .onAppear{
            viewModel.getOrders()
        }
        .sheet(isPresented: $isOrderViewShow) {
            let orderViewModel = orderViewModel(order: viewModel.currentOrder)
            OrderView(viewModel: orderViewModel)
        }
        .fullScreenCover(isPresented: $isShowAuthView) {
            AutorizationView()
        }
        .sheet(isPresented: $isShowAddProduct) {
        AdminProductsList()
        }
    }
}
