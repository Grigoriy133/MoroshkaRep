//
//  AddProductView.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 21.08.2023.
//

import SwiftUI

struct AddProductView: View {
    
    @State private var isshowImagePicker = false
    @State private var image = UIImage(named: "PP")!
    @State private var title: String = ""
    @State private var descripytion: String = ""
    @State private var price: Int? = nil
    @State private var isRecomeneded : Bool = false
    //чтобы что-то убрать вью
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Добавить товар")
                .bold()
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 320)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30)
                .onTapGesture {
                    isshowImagePicker.toggle()
                }
            TextField("Название продукта", text: $title)
                .padding()
            TextField("Цена продукта", value: $price, format: .number)
                .padding()
                .keyboardType(.numberPad)
            TextField("Описание продукта", text: $descripytion)
                .padding()
            Toggle("По акции?", isOn: $isRecomeneded)
            
            Button {
                guard let price = price else {
                    return
                }
                let product = ProductModel(id: UUID().uuidString, name: title, price: price, description: descripytion, isRecomended: isRecomeneded)
                guard let imageData = image.jpegData(compressionQuality: 0.3) else {
                    return
                }
                DatabaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result {
                    case .success(_):
                        dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Сохранить")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(Color.green)
                    .cornerRadius(10)
                    
            } .padding()

        } .padding()
        .sheet(isPresented: $isshowImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}
