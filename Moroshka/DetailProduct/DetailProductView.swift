//
//  DetailProductView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 02.08.2023.
//

import SwiftUI

struct DetailProductView: View {
   
    @ObservedObject var viewModel: DetailViewModel
    @State var size = Size.Small
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .frame(width: screen.width * 0.9, height: screen.height * 0.5, alignment: .bottom)
            } else {
                ProgressView()
                    .foregroundColor(Color("mainColor4"))
            }
            VStack{
                HStack{
                    Picker("Размер", selection: $size) {
                        ForEach(viewModel.sizes, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }.pickerStyle(.menu)
                        .foregroundColor(Color("mainColor4"))
                        .padding(.leading, 24)
                    Spacer()
                    Stepper("", value: $count, in: 1...10)
                        .foregroundColor(Color("mainColor4"))
                        .padding(.trailing, 24)
                }
                
                HStack{
                    Text(viewModel.product.name)
                    //   .foregroundColor(Color("mainColor4"))
                        .bold()
                        .frame(alignment: .leading)
                        .padding(.leading, 34)
                    Spacer()
                    Text("\(count) шт")
                    //  .foregroundColor(Color("mainColor4"))
                        .bold()
                    Spacer()
                    Text("\(viewModel.calculatePrice(size: size)) Рублей")
                    //  .foregroundColor(Color("mainColor4"))
                        .bold()
                        .frame(alignment: .trailing)
                        .padding(.trailing, 24)
                }
                
                Text("\(viewModel.product.description)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)
                .padding(.leading, 34) } .padding(.horizontal, 1)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.5))
            
            Button(action: {
                var newPosition = Position(id:
                                            UUID().uuidString,
                                           product: viewModel.product,
                                           count: count)
                newPosition.product.price = viewModel.calculatePrice(size: size)
                BasketViewModel.shared.addPossition(newPossition: newPosition)
                //свернуть вью
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("В корзину")
                    .padding()
                    .padding(.horizontal, 90)
                    .background(Color("mainColor2"))
                    .cornerRadius(15)
                    .foregroundColor(Color.white)
            })
            Spacer()
        } .background(Image("back"))
            .onAppear(){
                viewModel.getImage()
            }
    }
}

