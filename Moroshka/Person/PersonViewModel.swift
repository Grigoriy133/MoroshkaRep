//
//  PersonViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 19.08.2023.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published var currentProfile: UserModel
    @Published var orders = [Order]()
    
    init(currentProfile: UserModel) {
        self.currentProfile = currentProfile
   }
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: AuthService.shared.currentUser!.uid){ result in
            print(AuthService.shared.currentUser!.uid)
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
                print(orders.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile(){
        DatabaseService.shared.setUser(user: currentProfile){ result in
            switch result {
            case.success(let user):
                print(user.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile(){
       
        DatabaseService.shared.getUser{ result in
            switch result {
            case .success(let user):
                self.currentProfile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
