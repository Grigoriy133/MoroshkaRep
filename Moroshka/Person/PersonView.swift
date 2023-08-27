//
//  PersonView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import SwiftUI

struct PersonView: View {

    @State var isOutMenuPresented = false
    @State var isPresented = false
    
    @StateObject var viewModel: PersonViewModel

    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Image("human")
                    .resizable()
                    .padding(8)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Spacer()
                VStack(alignment: .center, spacing: 0){
                    TextField("Имя", text: $viewModel.currentProfile.name)
                        .bold()
                    HStack {
                        Text("+7")
                            .bold()
                        TextField("Телефон", text: $viewModel.currentProfile.phone)
                            .bold()
                            .keyboardType(.decimalPad)

                    }
                }.frame(width: screen.width * 0.45)
                    Spacer()
                    Button {
                        AuthService.shared.signOut()
                        isOutMenuPresented.toggle()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                    }.padding(.trailing, 8)
            }.padding(.horizontal, 8)
                .background(Color.white.opacity(0.5))
            
           
            VStack(alignment: .center){
                List{
                    if viewModel.orders.count == 0 {
                        Text("Здесь будут ваши заказы")
                    } else {
                        ForEach(viewModel.orders, id: \.id) { order in
                            OrderCell(order: order)
                                .listRowBackground(Color.white.opacity(0.5))
                        }
                    }
                }
                
                .scrollContentBackground(.hidden)
            }
        }.background(Image("back"))
        .onSubmit {
            self.viewModel.setProfile()
        }
        .onAppear {
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
        .confirmationDialog("Действительно выйти?", isPresented: $isOutMenuPresented){
            Button{
                isPresented.toggle()
            } label: {
                Text("Да")
            }
        }
        .fullScreenCover(isPresented: $isPresented){
            AutorizationView()
        }
    }
}

