//
//  orderViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 21.08.2023.
//

import Foundation
 
class orderViewModel: ObservableObject {
    @Published var order: Order
    @Published var user = UserModel(id: "", name: "", phone: "", adress: "")
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData(){
        DatabaseService.shared.getUser(by: order.userId){ result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
