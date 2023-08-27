//
//  DetailProductViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 05.08.2023.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
   @Published var product: ProductModel
   @Published var sizes = [Size.Small, Size.Medium, Size.Large]
    @Published var image = UIImage(named: "PP")
    

    func calculatePrice(size: Size) -> Int {
        switch size{
        case .Small: return product.price
        case .Medium: return Int(Double(product.price) * 1.25)
        case .Large: return Int(Double(product.price) * 1.5)
        }
    }
    
    func getImage() {
        StorageService.shared.downLoadImage(id: product.id) { result in
            switch result {
            case .success(let data):
                if let img = UIImage(data: data) {
                    self.image = img
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
    init(product: ProductModel) {
        self.product = product
    }
}

enum Size: String{
    case Small = "Small"
    case Medium = "Medium"
    case Large = "Large"
}
