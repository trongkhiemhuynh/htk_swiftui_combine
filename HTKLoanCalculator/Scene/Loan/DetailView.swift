//
//  DetailView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 5/23/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorSch: ColorScheme
    
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            Text(Constants.flatRateText)
            Spacer()
        }
    }
}
