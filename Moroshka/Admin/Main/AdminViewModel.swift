//
//  AdminViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 21.08.2023.
//

import Foundation

class AdminViewModel: ObservableObject {
   @Published var orders = [Order]()
    var currentOrder = Order(userID: "",  date: Date(), status: "Новый")
    
    func getOrders(){
        DatabaseService.shared.getOrders(by: AuthService.shared.adminId) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].possitions = positions
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
