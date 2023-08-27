//
//  AdminPorductListViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 25.08.2023.
//

import Foundation

class AdminProductListViewModel: ObservableObject {
    @Published var productsArray = [ProductModel]()

    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.productsArray = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func deleteProduct(product: ProductModel){
        DatabaseService.shared.deleteProduct(product: product) {  result in
            switch result {
            case .success(_):
                print("delete")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
