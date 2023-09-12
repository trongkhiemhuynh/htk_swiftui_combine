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
                    
                    TextField("username", text: self.$viewModel.tfUsername) {
                        print("endediting")
                        UIApplication.shared.endEditing()
                    }.textFieldStyle(.roundedBorder).padding([.leading, .trailing])
                    
                    SecureField("password", text: self.$viewModel.tfPassword) {
                        UIApplication.shared.endEditing()
                        print("endediting123")
                    }.textFieldStyle(.roundedBorder).padding([.leading, .trailing])

                    Text("LOGIN")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .padding()
                        .background(Color.black)
                        .shadow(radius: 23).onTapGesture {
                            self.viewModel.onRequestLogin()
                        }.fullScreenCover(isPresented: self.$viewModel.isResolve) {
                            MainView(tabbarRouter: TabBarRouter())
                        }
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
