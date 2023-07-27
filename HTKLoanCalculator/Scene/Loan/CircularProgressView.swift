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
            Text("\(viewModel.percentage) %").frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .overlay(
                    ZStack {
                        Circle().stroke(Color.pink.opacity(0.5), lineWidth: 10).background(Color.clear)
                        Circle().trim(from: 0, to: viewModel.percentage).stroke(Color.pink, style: StrokeStyle(lineWidth: 10, lineCap: .round)).rotationEffect(.degrees(-90))
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
                                
    var percentage: Double
    
    init(percentage: Double) {
        self.percentage = percentage
    }
}
