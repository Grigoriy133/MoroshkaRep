//
//  BasketCell.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 06.08.2023.
//

import SwiftUI


struct BasketCell: View {
   
    var position: Position
    
    var body: some View {
        HStack {
            Image(systemName: "cup.and.saucer")
            Text("\(position.product.name)")
               // .foregroundColor(Color.white)
                .font(.system(size: 12))
                .frame(width: 60, alignment: .leading)
            Spacer()
            Text("\(position.count) шт")
             //   .foregroundColor(Color.white)
                .font(.system(size: 12))
            Spacer()
            Text("\(position.cost) Рублей")
             //   .foregroundColor(Color.white)
                .font(.system(size: 12))
                .bold()
                .frame(width: 120, alignment: .trailing)
        } .padding(.horizontal, 1)
        
            .frame(height: 30)
    }
}
