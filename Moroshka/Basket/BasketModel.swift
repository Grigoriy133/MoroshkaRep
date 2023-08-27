//
//  BasketModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 05.08.2023.
//

import Foundation
import FirebaseFirestore
//протокол необходимый для того, чтобы эта структура могла быть Датасорсом таблицы
struct Position: Identifiable {
    var count: Int
    var product: ProductModel
    var id: String
    
    var cost: Int {
        return self.product.price * self.count
    }
    
    var representation: [String:Any] {
        var repres = [String:Any]()
        
        repres["id"] = id
        repres["count"] = count
        repres["title"] = product.name
        repres["cost"] = cost
        repres["price"] = product.price
        
        return repres
    }
    
    internal init(id: String, product: ProductModel, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let title = data["title"] as? String else {return nil}
        guard let price = data["price"] as? Int else {return nil}
        
        let product: ProductModel = ProductModel(id: "",
                                                 name: title,
                                                 price: price,
                                                 description: "",
                                                 ImageURL: "")
        
        guard let count = data["count"] as? Int else {return nil}
        
        self.id = id
        self.product = product
        self.count = count
    }
    
}
