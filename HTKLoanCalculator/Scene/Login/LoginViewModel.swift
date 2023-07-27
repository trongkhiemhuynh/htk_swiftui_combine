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
    @Published var isLoading: Bool = false
    
    init() {
        
    }
    
    func onRequestLogin() {
        print("OOOOOO")
        self.isLoading = true
        self.someAsyncronousTask { value in
            self.isResolve = value
            
            self.isLoading = false
        }
        
//        if (tfUsername == "dragon" && tfPassword == "abc123456") {
//            print("success")
//            self.isResolve = true
//        } else {
//            self.isResolve = false
//            print("failed")
//        }
        
    }
    
    private func someAsyncronousTask(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Waited 3 seconds to simulate something like URLSession request
            let checked = true//self.tfUsername == "dragon" && self.tfPassword == "abc123456"
            completion(checked)
        }
    }
}
