//
//  TextViewCustom.swift
//  HTKLoanCalculator
//
//  Created by LDCC MacbookPro on 27/07/2023.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        uiView.attributedText = text
    }
    
    typealias UIViewType = UITextView

}
