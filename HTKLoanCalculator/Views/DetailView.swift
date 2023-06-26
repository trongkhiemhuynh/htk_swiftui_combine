//
//  DetailView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 5/23/23.
//

import Foundation
import SwiftUI
//import MyPackage

struct DetailView: View {
    
    @Environment(\.colorScheme) var colorSch: ColorScheme
    var action: (() -> Void)?
    
//    @Binding var presentedAsModal: Bool
    
    var body: some View {
        VStack(alignment: .center) {
//            Button {
//                self.presentedAsModal = false
//            } label: {
//                Text("Dismiss")
//            }
            Text(Constants.flatRateText)
            Spacer()
        }
    }
    
//    func onChanged(action: @escaping ()->Void) -> Self {
//        print(withUnsafePointer(to: &self, { add in
//            print(add)
//        }))
//        var copy = self
////        print(Unmanaged.passUnretained(&copy).toOpaque())
//        copy.action = action
////        print(Unmanaged.passUnretained(&someVar).toOpaque())
//        return copy
//    }
}
