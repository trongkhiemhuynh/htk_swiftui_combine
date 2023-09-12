//
//  PrincipalDetailView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/26/23.
//

import SwiftUI

///
///Month, Principle, Interest, Payment
///

struct PrincipalDetailView: View {

    let _data: [PricipalItem] =  {
        var items = [PricipalItem]()

        let data = (1...100).map { element in
            PricipalItem(order: element, principal: "principal", interest: "interest", payment: "payment")
        }

        items.append(contentsOf: data)

        return items
    }()
    
    var datas: [PricipalItem]
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            Section {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(datas, id: \.id) { item in
                        HStack {
                            Text("\(item.order)").frame(maxWidth: .infinity, alignment: .leading).background(Color.red)
                            Text("\(item.principal)").frame(maxWidth: .infinity, alignment: .leading).background(Color.blue)
                            
                            Text("\(item.interest)").frame(maxWidth: .infinity, alignment: .leading).background(Color.blue)
                            
                            Text("\(item.payment)").frame(maxWidth: .infinity, alignment: .leading).background(Color.blue)
                        }
                    }
                }
            } header: {
                HStack(alignment: .top) {
                    Text("Month")
                    Spacer()
                    Text("Principle")
                    Spacer()
                    Text("Interest")
                    Spacer()
                    Text("Payment")
                    Spacer()
                }
            } footer: {
                Text(String("Aug28"))
            }
            
            
        }//.frame(maxHeight: .infinity)
    }
}

struct PrincipalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalDetailView(datas: [])
    }
}

struct PricipalItem: Identifiable {
    let id = UUID()
    let order: Int
    let principal: String
    let interest: String
    let payment: String
}
