//
//  CatalogViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import Foundation

class CatalogViewModel : ObservableObject {
    
    static let shared = CatalogViewModel()
   @Published var produtsArray = [ProductModel]()
   @Published var saleProsuctsArray = [ProductModel]()
    
    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.produtsArray = products
                self.getSaleProducts()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    func getSaleProducts(){
        for prod in produtsArray {
            if prod.isRecomended {
                saleProsuctsArray.append(prod)
                print(saleProsuctsArray.count)
            }
        }
    }
}
