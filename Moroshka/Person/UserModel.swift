//
//  UserModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 19.08.2023.
//

import Foundation

struct UserModel: Identifiable {
    var id: String
    var name: String
    var phone: String
    var adress: String
    
    var representation: [String: Any]{
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["adress"] = self.adress
        
        return repres
    }
}
