//
//  Model.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import Foundation
import FirebaseFirestore

struct ProductModel {
    var id: String
    var name: String
    var price: Int
    var description: String
    var ImageURL: String = ""
    var isRecomended = false
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["price"] = self.price
        repres["description"] = self.description
        repres["isRecomended"] = self.isRecomended
        
        return repres
    }
    internal init(id: String = UUID().uuidString, name: String, price: Int, description: String, ImageURL: String = "", isRecomended: Bool = false) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.ImageURL = ImageURL
        self.isRecomended = isRecomended
    }
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else {return nil}
        guard let name = data["name"] as? String else {return nil}
        guard let price = data["price"] as? Int else {return nil}
        guard let description = data["description"] as? String else {return nil}
        guard let isRecomended = data["isRecomended"] as? Bool else {return nil}
        
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.isRecomended = isRecomended
        
    }
    
}
