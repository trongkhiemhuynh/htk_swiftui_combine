//
//  MainViewModel.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/22/23.
//

import Foundation
import Combine
import SwiftUI
import Hello_Image

class LoanViewModel: ObservableObject {
    @Published var loanAmount: String = ""
    @Published var loanTerm: String = ""
    @Published var interestRate: String = ""
    @Published var interestType: Int = 0
    @Published var var1: String = ""
    
    @Published var __loanAmount: Int = 0

    
    @Published var textDescriptionMethod: NSMutableAttributedString = NSMutableAttributedString(string: Constants.flatRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .bold)])
    
    @Published var shortInputMoneySegment: Int = 100
    @Published var termSelect: Int = 0
    
    var cancelable: Set<AnyCancellable> = []
    
    var isValidateLoan = CurrentValueSubject<Bool, Never>(false)
    var isValidateTerm = CurrentValueSubject<Bool, Never>(false) //(Int(self.loanTerm) ?? 0) > 0
    var isValidateIRate = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestRate) ?? 0) > 0
//    var isValidateIType = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestType) ?? 0) > 0
    
//    @Published var showCircleView: Bool = false
    
    // Output
    @Published var totalPayment: Double = 0
    @Published var totalInterest: Double = 0
    @Published var monthlyPaid: Double = 0
    @Published var percentage: Double = 0
    
     public init() {
         /// Validate loan amount
         
         IPFactory.saySomething()
         
         self.$loanAmount.sink { val in
             self.isValidateLoan.send((Int(val) ?? 0) > 0)
         }.store(in: &cancelable)
         
         self.$loanTerm.sink { val in
             self.isValidateTerm.send((Int(val) ?? 0) > 0)
         }.store(in: &cancelable)
         
         self.$interestRate.sink { val in
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
                     self.loanAmount += "000000"
                 case 2:
                     self.loanAmount += "000000000"
                 case 3:
                     self.loanAmount.removeAll()
                 default:
                     self.loanAmount.removeAll()
                 }
             }
             
         }.store(in: &cancelable)

         self.isValidateLoan.sink { __value in
             print("check subject isValidateLoan", __value)
         }.store(in: &cancelable)
         
         
         /// done validate all values
         print("xxxx")
         print(self.isValidateLoan.value)
         print(self.isValidateTerm.value)
         print(self.isValidateIRate.value)
         
         
         
//         if (self.isValidateLoan.value && self.isValidateTerm.value && self.isValidateIRate.value) {
//         Publishers.CombineLatest
         let __publisher = Publishers.CombineLatest(self.$termSelect, self.$loanAmount)
//         Publishers.CombineLatest(__publisher, Publishers.CombineLatest3(self.$loanTerm, self.$interestRate, self.$interestType)).sink { tuplesData in
//             print("CombineLatest debuging ...")
////             print(tuplesData.0, tuplesData.1, tuplesData.2.0, tuplesData.2.1, tuplesData.2.2)
//
//             /*
//              named to clearly
//              validate all fields -> return
//              check interest type flat or reduce
//              caculate and binding to circle ring, text
//
//              */
//             let termSelected = tuplesData.0.0
//             let loanAmount = tuplesData.0.1
//             let loanTerm = tuplesData.1.0
//             let interestRate = tuplesData.1.1
//             let interestType = tuplesData.1.2
//
////             if (!(loanAmount.count > 0 && loanTerm.count > 0 && interestRate.count > 0)) {
////                 return
////             }
//
//             if (interestType == 0) { // Flat method
//                 print("hello flat")
//                 /*
//                  check selected month or year
//                  */
//                 var timeLoan: Int = 0
//
//                 if (termSelected == 0) { // year duration
//                     timeLoan = Int(loanTerm)! * 12
//
//                 } else {
//                     timeLoan = Int(loanTerm)!
//                 }
//
//                 self.totalPayment = Double(loanAmount)! * Double(interestRate)! * pow((1 + Double(interestRate)!), Double(timeLoan)) / (pow((1 + Double(interestRate)!), Double(timeLoan)) - 1)
//                 self.totalInterest = self.totalPayment - Double(loanAmount)!
//                 self.monthlyPaid = self.totalPayment / timeLoan
//                 self.percentage = (Double(loanAmount)! / self.totalPayment) * 100
//             } else {
//                 print("hello reduce")
//             }
//
//         }.store(in: &cancelable)
//         }
         
             
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
