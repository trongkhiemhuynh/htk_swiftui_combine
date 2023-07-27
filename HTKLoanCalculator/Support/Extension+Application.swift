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
