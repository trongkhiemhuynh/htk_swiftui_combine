//
//  PrincipalDetailView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/26/23.
//

import SwiftUI

struct PrincipalDetailView: View {

    let _data: [PricipalItem] =  {
        var items = [PricipalItem]()
        let item1 = PricipalItem(orderItem: 1, paymentMoney: 0, titleOrder: "STT", titlePayment: "PRINCIPLE")
        items.append(item1)
        
        let data = (1...1000).map { element in
            PricipalItem(orderItem: element, paymentMoney: 1410.90)
        }
        
        items.append(contentsOf: data)
        
        return items
    }()
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(_data, id: \.id) { item in
                    HStack {
                        if (!item.titleOrder.isEmpty) {
                            Text("\(item.titleOrder)").frame(maxWidth: .infinity, alignment: .leading).background(Color.red)
                            Text("\(item.titlePayment)").frame(maxWidth: .infinity, alignment: .leading).background(Color.blue)
                        } else {
                            Text("\(item.orderItem)").frame(maxWidth: .infinity, alignment: .leading).background(Color.red)
                            Text("\(item.paymentMoney)").frame(maxWidth: .infinity, alignment: .leading).background(Color.blue)
                        }
                        
                    }
                }
            }
        }//.frame(maxHeight: .infinity)
    }
}

struct PrincipalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalDetailView()
    }
}

struct PricipalItem: Identifiable {
    var id = UUID()
    var orderItem: Int
    var paymentMoney: Double
    var titleOrder: String = ""
    var titlePayment: String = ""
}
