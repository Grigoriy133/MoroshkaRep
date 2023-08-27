//
//  ProductCell.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 30.07.2023.
//

import SwiftUI


struct ProductCell: View {
    
    @State var product: ProductModel
    @State var image = UIImage(named: "PP")
    var isItMainCell: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isItMainCell ? screen.width * 0.3: screen.width * 0.45)
                .clipped()
            HStack{
                Text(product.name)
                    .font(.custom("AvenirNext-regular", size: isItMainCell ? 8: 10))
                    
                Text(" \(product.price) Руб")
                    .font(.custom("AvenirNext-bold", size: isItMainCell ? 8: 10))
                    .foregroundColor(isItMainCell ? Color.red : Color.black)
            }.padding(isItMainCell ? 6 : 12)
            .background(Color.white)
            .cornerRadius(10)
            .offset(y: 0)
        }
        .frame(width: (isItMainCell ? screen.width * 0.3 : screen.width * 0.45), height: (isItMainCell ? screen.width * 0.3 : screen.width * 0.45))
        .background(Color("lightGrayColor"))
        .cornerRadius(15)
        .shadow(radius: 4)
        .onAppear(){
            StorageService.shared.downLoadImage(id: self.product.id) { result in
                switch result {
                case .success(let data):
                    if let img  = UIImage(data: data) {
                        DispatchQueue.main.async {
                                            self.image = img
                                        }
                    }
                case .failure(let error):
                print(error)
                }
            }
        }
    }
}

