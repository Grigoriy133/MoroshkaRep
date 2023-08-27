//
//  BasketView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import SwiftUI

struct BasketView: View {

 //модификатор наблюдаемости модели
    @StateObject var viewModel: BasketViewModel

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                List {
                    if viewModel.possitionArray.count == 0 {
                        Text("Корзина пока пустая")
                            .listRowBackground(Color.white.opacity(0.5))
                    } else {
                        ForEach(viewModel.possitionArray) { pos in
                            BasketCell(position: pos)
                                .listRowBackground(Color.white.opacity(0.5))
                                .swipeActions(content: {
                                    Button(action: {
                                        viewModel.possitionArray.removeAll { position in
                                            position.id == pos.id
                                        }
                                    }, label: {
                                        Text("Удалить")
                                    })
                                }).tint(.red)
                        }
                    }
                }

                .background(Image("back"))
                //изменить цвет фона таблицы!!
                .scrollContentBackground(.hidden)
                HStack {
                        Text("Итого:")
                            .frame(width: 80)
                          //  .foregroundColor(Color.white)
                      Spacer()
                        Text("\(viewModel.finalCost) Рублей")
                            .frame(width: String(viewModel.finalCost).count > 1 ? 140 : 80)
                            .padding(.trailing, 8)
                            .bold()
                         //   .foregroundColor(Color.white)
                    }.padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
              
                Spacer()
                    .frame(height: 10)
                HStack {
                   
                    Button(action: {
                        var order = Order(userID: AuthService.shared.currentUser!.uid,
                                          date: Date(),
                                          status: OrderStatus.new.rawValue)
                        
                        order.possitions = self.viewModel.possitionArray
                        if order.cost > 0 {
                            DatabaseService.shared.setOrder(order: order) { result in
                                switch result {
                                case .success(let order):
                                    print(order.cost)
                                    viewModel.possitionArray = [Position]()
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                    }, label: {
                        Text("Заказать")
                           .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .padding()
                            .background(Color("mainColor2"))
                            .cornerRadius(15)
                            .foregroundColor(Color.white)
                    }).padding(.horizontal, 10)
                }
               
                Spacer()
                    .frame(height: 20)
            }
            //надпись почему-то должна быть внутри navigationView
            .navigationBarItems(leading: Text("Корзина")
                .bold()
                .font(.system(size: 36)), trailing:
                                    Button(action: {
                viewModel.possitionArray = [Position]()
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            })
            )
        }
       
        
    }
    
}
