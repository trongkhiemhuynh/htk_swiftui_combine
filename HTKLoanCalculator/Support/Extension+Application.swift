//
//  Extension+Application.swift
//  HTKLoanCalculator
//
//  Created by LDCC MacbookPro on 27/07/2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double {
    func formattter() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
