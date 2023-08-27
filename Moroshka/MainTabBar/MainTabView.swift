//
//  MainTabView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import SwiftUI

struct MainTabView: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            NavigationView() {
                
                CatalogView(viewModel: CatalogViewModel.shared)
            }
                    .tabItem{
                        VStack {
                            Image(systemName: "list.clipboard")
                            Text("Каталог")
                        }
                    }
            BasketView(viewModel: BasketViewModel.shared)
                .tabItem{
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            PersonView(viewModel: PersonViewModel(currentProfile: UserModel(id: "", name: "", phone: "", adress: "")))
                .tabItem{
                    VStack {
                        Image(systemName: "person")
                        Text("Пользователь")
                    }
                }
        } .accentColor(.black)
            .background(Color.white)
    }
}
