//
//  adminProductCell.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 26.08.2023.
//

import SwiftUI

struct adminProductCell: View {
   
    @State var product: ProductModel
    
    var body: some View {
        HStack{
            Text("\(product.name)")
            Spacer()
            Text("\(product.price)")
        }
    }
}

