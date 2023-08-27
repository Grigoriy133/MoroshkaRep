//
//  OrderView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 21.08.2023.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel: orderViewModel
    
    var statuses: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(viewModel.user.name)")
                .bold()
            Text("\(viewModel.user.phone)")
            Text("\(viewModel.user.adress)")
            
            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Статусы заказа")
            }
            .pickerStyle(.menu)
            .onChange(of: viewModel.order.status) { newStatus in
                DatabaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                    case .success(let order):
                        print(order.status)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }

            List {
            ForEach(viewModel.order.possitions, id: \.id) { position in
                BasketCell(position: position)
            }
                Text("Итого: \(viewModel.order.cost) рублей")
        }
        }.padding()
            .onAppear(){
                viewModel.getUserData()
            }
        
        
    }
}
