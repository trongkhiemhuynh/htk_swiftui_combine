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
    
    @Published var __loanAmount: Int = 0
    @Published var __percentage: Double = 0.0
    @Published var __totalPaid: Double = 0
    @Published var __monthlyPaid: Double = 0
    
    @Published var textDescriptionMethod: NSMutableAttributedString = NSMutableAttributedString(string: Constants.flatRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .bold)])
    
    @Published var shortInputMoneySegment: Int = 100
    @Published var termSelect: Int = 0
    
    var cancelable: Set<AnyCancellable> = []
    
    var isValidateLoan = CurrentValueSubject<Bool, Never>(false)
    var isValidateTerm = CurrentValueSubject<Bool, Never>(false) //(Int(self.loanTerm) ?? 0) > 0
    var isValidateIRate = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestRate) ?? 0) > 0
    var isValidateIType = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestType) ?? 0) > 0
    
    @Published var showCircleView: Bool = false
    
    // Output
    @Published var mortgagePayments: Double = 0
    
     public init() {
         /// Validate loan amount
         self.$loanAmount.sink { val in
             self.isValidateLoan.send((Int(val) ?? 0) > 0)
             
             print("Value change \(val) \(self.isValidateLoan) ", val.count)
         }.store(in: &cancelable)
         
         self.$loanTerm.sink { val in
             
             print("Value change \(val) \(self.isValidateTerm)")
             self.isValidateTerm.send((Int(val) ?? 0) > 0)
         }.store(in: &cancelable)
         
         self.$interestRate.sink { val in
//             self.isValidateIRate = val.count > 0
             print("Value change \(val) \(self.isValidateIRate)")
             self.isValidateIRate.send((Int(val) ?? 0) > 0)
         }.store(in: &cancelable)
         
         
         self.$shortInputMoneySegment.sink { completion in
             print("completion input shortcut", completion)
         } receiveValue: { value in
             print("hello short cut")
             print(value)
             
             if (self.loanAmount.count > 0) {
                 switch value {
                 case 0:
                     self.loanAmount += "000"
                 case 1:
                     self.loanAmount += "000.000"
                 case 2:
                     self.loanAmount += "000.000.000"
                 case 3:
                     self.loanAmount.removeAll()
                 default:
                     self.loanAmount.removeAll()
                 }
             }
             
         }.store(in: &cancelable)

         
         
         self.isValidateLoan.sink { __value in
             print("check subject ", __value)
         }.store(in: &cancelable)
//         if (isValidateLoan && isValidateTerm && isValidateIRate && isValidateIType) {
             print("debuggggggggg")
             self.showCircleView = true
             
             Publishers.CombineLatest(self.$termSelect, Publishers.CombineLatest4(self.$loanAmount, self.$loanTerm, self.$interestRate, self.$interestType)).sink { tuplesData in
                 print("debuging ...")
                 print(tuplesData.0, tuplesData.1, tuplesData.1.0, tuplesData.1.1, tuplesData.1.2)
             }.store(in: &cancelable)
             
             /*
             Publishers.CombineLatest4(self.$loanAmount, self.$loanTerm, self.$interestRate, self.$interestType).sink { tuples in
                 
                 self.__loanAmount = Double(tuples.0) ?? 0
                 
                 self.__percentage = (((Double(tuples.2) ?? 0)*_loanAmount - _loanAmount)/_loanAmount)*100
                 
                 self.__totalPaid = (_loanAmount + self.__percentage)
                 
                 
    //             print(loanAmount, tuples.1, tuples.2, tuples.3)
                
                 // check type loan
                 if (tuples.3 == 100) { // Flat rate method
    //                 print("Flat rate method")
                     self.textDescriptionMethod = NSMutableAttributedString(string: Constants.flatRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])//NSMutableAttributedString(string: Constants.flatRateText)
                     
                     /// MARK: Equation for mortgage payments
//                     M = P*
//                           *r* (1 + r)n /
//                                          (1 + r)n - 1
                     
                     let monthValue: Double = (self.termSelect == 0) ? 12 : 12
                     
                     if let monthlyInterestRate = Double(tuples.2) {
                         self.mortgagePayments = _loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), monthValue) / (pow((1 + monthlyInterestRate), monthValue) - 1)
                     }
                     
                                                
                     
                     
                 } else { // Reduce balance
    //                 print("Reduce balance")
                     self.textDescriptionMethod = NSMutableAttributedString(string: Constants.reduceRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])//NSMutableAttributedString(string: Constants.reduceRateText)
                 }
                 
             }.store(in: &cancelable)
              */
//         }
         
    }
    
    public func onChangeLoanAmount() {
        print("onChangeLoanAmount ",self.loanAmount)

    }
}
