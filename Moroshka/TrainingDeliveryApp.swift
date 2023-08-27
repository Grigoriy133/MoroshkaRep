//
//  TrainingDeliveryApp.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 28.07.2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

let screen = UIScreen.main.bounds
@main
struct TrainingDeliveryApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            
        
            if let user = AuthService.shared.currentUser {
                if user.uid == "Ag7sNEl4JJXKacs8C0y2QqxgFyo1" {
                    AdminView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabView(viewModel: viewModel)
                }
               
            } else {
                AutorizationView()
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
           FirebaseApp.configure()
            
            return true
        }
    }
    
}
