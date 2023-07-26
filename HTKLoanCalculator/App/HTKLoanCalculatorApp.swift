//
//  HTKLoanCalculatorApp.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 5/23/23.
//

import SwiftUI

@main
struct HTKLoanCalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
//        WindowGroup {
////            MainView(tabbarRouter: TabBarRouter())
//            LoginView()
//        }
        
        WindowGroup {
            LoginView()
        }
    }
}
