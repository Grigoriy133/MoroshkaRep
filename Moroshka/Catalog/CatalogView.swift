//
//  CatalogView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import SwiftUI

struct CatalogView: View {
    
    @StateObject var viewModel: CatalogViewModel
   
    let layout = [GridItem(.adaptive(minimum: screen.width * 0.45), spacing: 10, alignment: .leading)]
    let layoutV = [GridItem(.adaptive(minimum: screen.width * 0.45), spacing: 1, alignment: .center)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
            Image("mainLogo")
                .resizable()
                .cornerRadius(15)
                    .frame(width: screen.width * 0.92)
                    .aspectRatio(contentMode: .fit)
                    
                
            Section(header: Text("Сегодня со скидкой")
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(30))
                    {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, alignment: .center, spacing: 5) {
                        ForEach(CatalogViewModel.shared.saleProsuctsArray, id: \ .id) { item in
                            NavigationLink{
                                    let viewModel = DetailViewModel(product: item)
                                    DetailProductView(viewModel: viewModel)
                            } label: {
                                //тут берем данные из ячейки
                                ProductCell(product: item, isItMainCell: true)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                } .padding()
            }
            Section(header: Text("Летнее меню")
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(30)) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutV) {
                        ForEach(CatalogViewModel.shared.produtsArray, id: \ .id) { item in
                            NavigationLink{
                             
                                    let viewModel = DetailViewModel(product: item)
                                    DetailProductView(viewModel: viewModel)
                                
                            } label: {
                                ProductCell(product: item, isItMainCell: false)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                } .padding()
            }
            .onAppear(){
                viewModel.getProducts()
                viewModel.getSaleProducts()
            }
        } .background(Image("back"))
    }
    
}

