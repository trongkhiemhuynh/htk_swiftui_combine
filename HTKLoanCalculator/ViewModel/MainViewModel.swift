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
    @Published var interestType: Int = 100
    @Published var var1: String = ""
    
    @Published var __loanAmount: String = ""
    @Published var __percentage: Double = 0
    @Published var __totalPaid: Double = 0.0.rounded()
    @Published var __monthlyPaid: Double = 0.0.rounded()
    
    @Published var textDescriptionMethod: NSMutableAttributedString!
    
    var cancelable: Set<AnyCancellable> = []
    
    @State var isValidateLoan = true
    @State var isValidateTerm = true //(Int(self.loanTerm) ?? 0) > 0
    @State var isValidateIRate = true //(Int(self.interestRate) ?? 0) > 0
    @State var isValidateIType = true //(Int(self.interestType) ?? 0) > 0
    
     public init() {
         /// Validate loan amount
         self.$loanAmount.sink { val in
             print("Value change \(val)")
             self.isValidateLoan = (Int(self.loanAmount) ?? 0) > 0
         }.store(in: &cancelable)
         
         let _term = self.$loanTerm.sink { val in
             
         }
         
         
         
         if (isValidateLoan && isValidateTerm && isValidateIRate && isValidateIType) {
             Publishers.CombineLatest4(self.$loanAmount, self.$loanTerm, self.$interestRate, self.$interestType).sink { tuples in
                 let loanAmount: String = tuples.0
                 
                 let _loanAmount = Double(loanAmount) ?? 0
                 self.__loanAmount = String(_loanAmount)
                 
                 self.__percentage = (((Double(tuples.2) ?? 0)*_loanAmount - _loanAmount)/_loanAmount)*100
                 
                 self.__totalPaid = (_loanAmount + self.__percentage)
                 
                 
    //             print(loanAmount, tuples.1, tuples.2, tuples.3)
                
                 // check type loan
                 if (tuples.3 == 100) { // Flat rate method
    //                 print("Flat rate method")
                     self.textDescriptionMethod = NSMutableAttributedString(string: Constants.flatRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])//NSMutableAttributedString(string: Constants.flatRateText)
                 } else { // Reduce balance
    //                 print("Reduce balance")
                     self.textDescriptionMethod = NSMutableAttributedString(string: Constants.reduceRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])//NSMutableAttributedString(string: Constants.reduceRateText)
                 }
                 
             }.store(in: &cancelable)
         }
         
    }
    
    public func onChangeLoanAmount() {
        print("onChangeLoanAmount ",self.loanAmount)

    }
}
