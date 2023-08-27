//
//  orderStatus.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 20.08.2023.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case complete = "Выполнено"
    case canceled = "Отменен"
    
}
