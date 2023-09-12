//
//  CircularProgressView.swift
//  HTKLoanCalculator
//
//  Created by LDCC MacbookPro on 26/07/2023.
//

import SwiftUI

struct CircularProgressView: View {
    //    @Binding var percentage: Double
    
    @ObservedObject var viewModel: CircularProgressViewModel
    
    var body: some View {
        GeometryReader { geo in
            Text("\(viewModel.strValue) %").frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .overlay(
                    ZStack {
                        Circle().stroke(Color.blue.opacity(1), lineWidth: 10).background(Color.clear)
                        Circle().trim(from: 0, to: viewModel.value).stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round)).rotationEffect(.degrees(-90))
                    }
                )
        }
        
    }
    
}


//struct CircularProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProgressView()
//    }
//}

class CircularProgressViewModel: ObservableObject {
                                
    var strValue: String
    let value: Double
    
    init(percentage: Double) {
        self.value = percentage
        self.strValue = (percentage*100).formattter()
    }
}
