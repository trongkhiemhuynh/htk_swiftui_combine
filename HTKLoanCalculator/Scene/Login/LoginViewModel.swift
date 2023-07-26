//
//  LoginViewModel.swift
//  HTKLoanCalculator
//
//  Created by LDCC MacbookPro on 26/07/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var tfUsername: String = "anonymous"
    @Published var tfPassword: String = ""
    @Published var isResolve: Bool = false
    
    init() {
        
    }
    
    func onRequestLogin() {
        print("OOOOOO")
        if (tfUsername == "dragon" && tfPassword == "abc123456") {
            print("success")
            self.isResolve = true
        } else {
            self.isResolve = false
            print("failed")
        }
    }
}
