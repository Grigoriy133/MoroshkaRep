//
//  BasketViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 05.08.2023.
//

import Foundation


public class BasketViewModel: ObservableObject {
    
    static let shared = BasketViewModel()
    //нужен если есть синг тон, хз зачем
    public init() {}
    
    @Published var possitionArray = [Position]()
    
    var finalCost: Int {
        var sum = 0
        for pos in self.possitionArray {
            sum += pos.cost
        }
   return sum
    }
    
    func addPossition(newPossition: Position) {
        possitionArray.append(newPossition)
    }
}
