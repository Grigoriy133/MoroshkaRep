//
//  MainTabBarViewModel.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 18.08.2023.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
