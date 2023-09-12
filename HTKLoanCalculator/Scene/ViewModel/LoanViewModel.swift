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
    @Published var yearMonthTimeType: Int = 0
    @Published var interestRate: String = ""
    @Published var FlatReduceInterestType: Int = 0

    
    @Published var textDescriptionMethod: NSMutableAttributedString = NSMutableAttributedString(string: Constants.flatRateText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .bold)])
    
    @Published var shortInputMoneySegment: Int = 100
    
    var cancelable: Set<AnyCancellable> = []
    
//    var isValidateLoan = CurrentValueSubject<Bool, Never>(false)
//    var isValidateTerm = CurrentValueSubject<Bool, Never>(false) //(Int(self.loanTerm) ?? 0) > 0
//    var isValidateIRate = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestRate) ?? 0) > 0
//    var isValidateIType = CurrentValueSubject<Bool, Never>(false) //(Int(self.interestType) ?? 0) > 0
    
//    @Published var showCircleView: Bool = false
    
    // Output
    @Published var totalPayment: String = "" //PassthroughSubject<Double, Never>()
    @Published var totalInterest: String = "" //PassthroughSubject<Double, Never>()
    @Published var monthlyPaid: String = ""
    @Published var percentage: Double = 0.5
    
    lazy var datas: Array<PricipalItem> = Array<PricipalItem>()
    
     public init() {
         /// Validate loan amount
//         self.$loanAmount.sink { val in
//             self.isValidateLoan.send((Int(val) ?? 0) > 0)
//         }.store(in: &cancelable)
//
//         self.$loanTerm.sink { val in
//             self.isValidateTerm.send((Int(val) ?? 0) > 0)
//         }.store(in: &cancelable)
//
//         self.$interestRate.sink { val in
//             self.isValidateIRate.send((Int(val) ?? 0) > 0)
//         }.store(in: &cancelable)
         
         
//         self.$shortInputMoneySegment.sink { completion in
//             print("completion input shortcut", completion)
//         } receiveValue: { value in
//             print("hello short cut")
//             print(value)
//
//             if (self.loanAmount.count > 0) {
//                 switch value {
//                 case 0:
//                     self.loanAmount += "000"
//                 case 1:
//                     self.loanAmount += "000000"
//                 case 2:
//                     self.loanAmount += "000000000"
//                 case 3:
//                     self.loanAmount.removeAll()
//                 default:
//                     self.loanAmount.removeAll()
//                 }
//             }
//
//         }.store(in: &cancelable)

//         self.isValidateLoan.sink { __value in
//             print("check subject isValidateLoan", __value)
//         }.store(in: &cancelable)T
//         Publishers.CombineLatest(self.$interestRate, self.$loanAmount).sink { outputResult in
//             self.totalPayment =
//         }.store(in: &cancelable)
         
         Publishers.CombineLatest4(self.$interestRate, self.$loanAmount, self.$loanTerm , self.$FlatReduceInterestType.combineLatest(self.$yearMonthTimeType)).sink { output in
             debugPrint("output")
             debugPrint(output)
             self.datas.removeAll()
             
             guard output.0.count > 0, output.1.count > 0, output.2.count > 0 else {return}
             
             guard let rateLoan = Double(output.0), let amountLoan = Double(output.1), var tenure = Double(output.2) else {return}
             
             let flatReduceType = output.3.0
             let yearorMonthType = output.3.1
             
             if (yearorMonthType == 1) {
                 // year duration
                 tenure = tenure / 12
             }
             
             if (flatReduceType == 0) {
                 //TODO: Flat method output.1
                 let partition = (Double(amountLoan)*Double(rateLoan)*(tenure))
                 let partition1 = (Double(amountLoan) + partition/100)
                 let monthCount = (tenure*12)
                 
                 self.totalPayment = partition1.formattter()

                 self.totalInterest = (partition/100).formattter()
                 
                 self.monthlyPaid = (partition1/monthCount).formattter()

                 self.percentage = (partition1 - amountLoan)/amountLoan
                 
                 /// loop all months
                 var __totalPayment = partition1
                 let _interestOnceMonth = (partition1)/monthCount
                 let strInterestMonth = _interestOnceMonth.formattter()
                 
                 for m in 1...Int(monthCount) {
                     self.datas.append(PricipalItem(order: (m), principal: __totalPayment.formattter(), interest: strInterestMonth, payment: self.monthlyPaid))
                     __totalPayment -= _interestOnceMonth
                 }
             } else {
                 // Reduce method balance
                 
                 
             }
             
         }.store(in: &cancelable)
         
         /// done validate all values
//         print("xxxx")
//         print(self.isValidateLoan.value)
//         print(self.isValidateTerm.value)
//         print(self.isValidateIRate.value)
         
         
         
//         if (self.isValidateLoan.value && self.isValidateTerm.value && self.isValidateIRate.value) {
//         Publishers.CombineLatest
//         let __publisher = Publishers.CombineLatest(self.$termSelectedType, self.$loanAmount)
         
//         let __publisher1 = Publishers.CombineLatest3(self.$loanTerm, self.$interestRate, $loanAmount)
         
//         __publisher1.sink { output in
//             print("xxxxxxxx")
//             print(output.0)
//             print(output.1)
//             print(output.2)
//             guard output.0.count > 0, output.1.count > 0, output.2.count > 0 else {return}
////             if (interestType == 0) {
//// Flat method
//                 print("hello flat")
//                 /*
//                  check selected month or year
//                  */
//                 var timeLoan: Int = 0
//
////                 if (termSelectedType == 0) { // year duration
//                     timeLoan = Int(output.0)! * 12
//
////                 } else {
////                     timeLoan = Int(loanTerm)!
////                 }
//
//                 self.totalPayment = String(Double(output.2)! * Double(output.1)! * pow((1 + Double(output.1)!), Double(timeLoan)) / (pow((1 + Double(output.1)!), Double(timeLoan)) - 1))
//                 self.totalInterest = Double(self.totalPayment)! - Double(output.2)!
////                 self.monthlyPaid = Double(self.totalPayment) / timeLoan
////                 self.percentage = (Double(output.2)! / Double(self.totalPayment)) * 100
//
////                 print(self.totalPayment, self.totalInterest, self.monthlyPaid, separator: "====")
////             } else {
//                 // Reduce method
//
////             }
//         }.store(in: &cancelable)
         /*
         Publishers.CombineLatest(__publisher, __publisher1/*, self.$interestType*/).sink { completion in
             print("hello com")
             print(completion)
         } receiveValue: { value in
             print("hello value")
             debugPrint(value)
             
             let termSelectedType = value.0.0
             let loanAmount = value.0.1
             let loanTerm = value.1.0
             let interestRate = value.1.1
             let interestType = 0
             
             if (!(loanAmount.count > 0 && loanTerm.count > 0 && interestRate.count > 0)) {
                 return
             }
             
             if (interestType == 0) {
                 // Flat method
                 print("hello flat")
                 /*
                  check selected month or year
                  */
                 var timeLoan: Int = 0
                 
                 if (termSelectedType == 0) { // year duration
                     timeLoan = Int(loanTerm)! * 12
                     
                 } else {
                     timeLoan = Int(loanTerm)!
                 }
                 
                 self.totalPayment = Double(loanAmount)! * Double(interestRate)! * pow((1 + Double(interestRate)!), Double(timeLoan)) / (pow((1 + Double(interestRate)!), Double(timeLoan)) - 1)
                 self.totalInterest = self.totalPayment - Double(loanAmount)!
                 self.monthlyPaid = self.totalPayment / timeLoan
                 self.percentage = (Double(loanAmount)! / self.totalPayment) * 100
                 
                 print(self.totalPayment, self.totalInterest, self.monthlyPaid, separator: "====")
             } else {
                 // Reduce method
                 
             }
             
         }.store(in: &cancelable)
*/
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

//

//
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
