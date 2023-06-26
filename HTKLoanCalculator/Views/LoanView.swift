//
//  LoanView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/22/23.
//

import SwiftUI

struct LoanView: View {
    
    @State var loanValue: String = ""
    @State var termSelect: Int = 0
    @State var termType: Int = 0
    @State var presentingModal: Bool = false
    @State var shortcutMoneySegment: Int = 0
    @State var showShortcutView: Bool = false
    @State var text: NSMutableAttributedString = NSMutableAttributedString(string: Constants.flatRateText)
    ////
    @ObservedObject var viewModel = MainViewModel() 
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                /// region one
                HStack(alignment: .center, spacing: 33) {
                    CircularProgressView().frame(width: 100
                                                 , height: 100).background(Color.clear)
                    
                    VStack(alignment: .leading) {
                        Text("Paid off").font(.headline)
                        Text("0 VND").font(.body)
                        Divider()
                        Text("Total interest").font(.headline)
                        Text("0 VND").font(.body)
                        Divider()
                        Text("Monthly paid").font(.headline)
                        Text("0 VND").font(.body)
                    }
                }.padding(.all)
                
                /// region two
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loan amount").font(.headline)
                    
                    TextField("Input money", text: $viewModel.loanAmount, onEditingChanged: { _ in
                        print("$0onEditingChanged")
                        showShortcutView = true
                        viewModel.onChangeLoanAmount()
                    }, onCommit: {
                        print("onCommit")
                        
                    }).textFieldStyle(.roundedBorder).onAppear {
                        print("textFieldStyle onAppear")
                    }
                    
//                    if (showShortcutView) {
//                        showShortcutView = false
                        HStack {
                            Spacer()
                            Picker("shortcut money", selection: $shortcutMoneySegment) {
                                Text(".000")
                                Text(".000.000")
                                Text(".000.000.000")
                            }.pickerStyle(.segmented)
                        }
//                    }
                    
                }.padding([.leading, .trailing])
                
                /// region three
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loan term").font(.headline)
                    
                    HStack {
                        TextField("Input term", text:  $viewModel.loanAmount, onEditingChanged: { _ in
                            print("$0onEditingChanged")
                        }, onCommit: {
                            print("onCommit")
                        }).textFieldStyle(.roundedBorder)
                        
                        Picker("What is your term?", selection: $termSelect) {
                            Text("years").tag(0)
                            Text("months").tag(1)
                        }.pickerStyle(.segmented)
                    }
                    
                }.padding([.leading, .trailing])
                
                
                /// region four
                VStack(alignment: .leading, spacing: 10) {
                    Text("Interest rate").font(.headline)
                    
                    HStack {
                        TextField("Input rate", text:  $viewModel.loanAmount, onEditingChanged: { _ in
                            print("$0onEditingChanged")
                        }, onCommit: {
                            print("onCommit")
                        }).textFieldStyle(.roundedBorder)
                        
                        Label("%", image: "")
                        
                    }
                    
                }.padding([.leading, .trailing])
                
                /// region five
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Interest type").font(.headline)
                        
                        Button {
                            self.presentingModal = true
                        } label: {
                            Image(systemName: "calendar")
                        }.sheet(isPresented: $presentingModal) {
                            NavigationLink(destination: DetailView()) {
//                                Text(Constants.flatRateText).foregroundColor(.black).font(.headline)
                                TextView(text: $text).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                                Spacer()
                            }
                        }

                    }
                    
                    Picker("What is your term type", selection: $termType) {
                        Text("Flat rate method").tag(0)
                        Text("Reduce balance method").tag(1)
                    }.pickerStyle(.segmented)
                    
                }.padding([.leading, .trailing])
//                Spacer()
//                RoundedRectangle(cornerSize: <#T##CGSize#>)
                
                
                VStack(alignment: .center) {
                    NavigationLink(destination: PrincipalDetailView()) {
                        Text("Result").frame(width: 300, height: 55).font(.headline).background(Color.red).cornerRadius(10.0).foregroundColor(Color.white)
                        
//                        Button {
//                            print("hello")
//
//                        } label: {
//
//                        }
                    }

                }
                
//                Toggle(isOn: <#T##SwiftUI.Binding<Bool>#>, label: <#T##() -> Label#>)
                
                
            }.navigationTitle("HTK Calculator").background(Color.white)
        }
    }
}

//struct LoanView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoanView()
//    }
//}

struct CircularProgressView: View {

    var body: some View {
        GeometryReader { geo in
            Text("7%").frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .overlay(
                    ZStack {
                    Circle().stroke(Color.pink.opacity(0.5), lineWidth: 20).background(Color.clear)
                    Circle().trim(from: 0, to: 0.25).stroke(Color.pink, style: StrokeStyle(lineWidth: 20, lineCap: .round)).rotationEffect(.degrees(-90))//.background(Color.pink)
                    }
                )
            
        }
        
    }
    
}

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
