//
//  LoginView.swift
//  HTKLoanCalculator
//
//  Created by LDCC MacbookPro on 26/07/2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        LoadingView(isShowing: .constant(self.viewModel.isLoading)) {
            NavigationView {
                VStack(alignment: .center, spacing: 23) {
                    Text("Hello, \(viewModel.tfUsername)")
                    
                    Image(systemName: "number.circle.fill")
                    
                    TextField("username", text: self.$viewModel.tfUsername).textFieldStyle(.roundedBorder).padding([.leading, .trailing])
                    SecureField("password", text: self.$viewModel.tfPassword).textFieldStyle(.roundedBorder).padding([.leading, .trailing])
                    
                    NavigationLink(destination: MainView(tabbarRouter: TabBarRouter()), isActive: self.$viewModel.isResolve, label: {
                        Button("LOGIN") {
                            
                            self.viewModel.onRequestLogin()
                        }
                        
                    })
                    
                    Spacer()
                    
                }.background(Color.red)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
