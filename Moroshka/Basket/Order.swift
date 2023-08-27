//
//  Order.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 20.08.2023.
//

import Foundation
import FirebaseFirestore

public struct Order {
    var id: String = UUID().uuidString
    var userId: String
    var possitions = [Position]()
    var date: Date
    var status: String
    var cost: Int {
        var sum = 0
        for possition in possitions {
            sum += possition.cost
        }
        return sum
    }
    
    var representation : [String: Any] {
        var repres = [String:Any]()
        
        repres["id"] = id
        repres["userId"] = userId
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        
        
        return repres
    }
    
    init(id: String = UUID().uuidString,
         userID: String,
         positions: [Position] = [Position](),
         date: Date,
         status: String) {
        self.id = id
        self.userId = userID
        self.possitions = positions
        self.date = date
        self.status = status
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else {return nil}
        guard let userID = data["userId"] as? String else {return nil}
        guard let date = data["date"] as? Timestamp else {return nil}
        guard let status = data["status"] as? String else {return nil}
        
        self.id = id
        self.userId = userID
        self.date = date.dateValue()
        self.status = status
    }
    
}
