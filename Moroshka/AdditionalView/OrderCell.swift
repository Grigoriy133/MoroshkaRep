//
//  OrderCell.swift
//  TrainingDelivery
//
//  Created by Grigoriy Korotaev on 20.08.2023.
//

import SwiftUI

struct OrderCell: View {
   var order: Order
    
    var body: some View {
        HStack {
            Text("\(formatDate(_:order.date))")
                .font(.system(size: 14))
                .frame(width: 120, alignment: .leading)
                .foregroundColor(Color.white)
                .padding(.leading, 52)
            Spacer()
            Text("\(order.cost) Руб")
                .font(.system(size: 14))
                .frame(width: 70)
                .foregroundColor(Color.white)
            Spacer()
            Text("\(order.status)")
                .font(.system(size: 14))
                .bold()
                .frame(width: 100, alignment: .trailing)
                .foregroundColor(Color.white)
                .padding(.trailing, 52)
        }.padding()
            .frame(height: 50)
    }
    func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            return formatter.string(from: date)
        }

}


