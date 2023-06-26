//
//  MainViewModel.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/22/23.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var loanAmount: String = ""
    @Published var loanTerm: String = ""
    @Published var interestRate: String = ""
    @Published var interestType: String = ""
    @Published var var1: String = ""
    
    @State var __loanAmount: String = ""
    
    fileprivate func doSomething() {
        print(self.$loanAmount)
        print("xxxxxxx")
        
        self.$loanAmount.sink { value in
            print("debugggggg ", value)
        }
        
//        self.$loanAmount.
    }
    
     public init() {
//        doSomething()
    }
    
    public func onChangeLoanAmount() {
        print("onChangeLoanAmount ",self.loanAmount)

    }
}
