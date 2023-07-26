//
//  LoanView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/22/23.
//

import SwiftUI

struct LoanView: View {
    
    @State var loanValue: String = ""

    @State var presentingModal: Bool = false
    
    @State var showShortcutView: Bool = false
    
    
    //// MARK: observed object
    @ObservedObject var viewModel: LoanViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                /// region one
                HStack(alignment: .center, spacing: 33) {
                    
                    CircularProgressView(viewModel: CircularProgressViewModel(percentage: self.viewModel.percentage))
                        .frame(width: 100, height: 100)
                        .background(Color.red)
                    
                    VStack(alignment: .leading) {
                        Text("Paid off").font(.caption).padding(4).foregroundColor(Color.white).background(Color.blue).cornerRadius(4)
                        Text("\(self.viewModel.totalPayment) $").font(.body)
                        Text("Total interest").font(.caption).padding(4).foregroundColor(Color.white).background(Color.blue).cornerRadius(4)
                        Text("\(self.viewModel.totalInterest) $").font(.body)
                        Divider()
                        Text("Monthly paid").font(.caption).padding(4).foregroundColor(Color.white).background(Color.blue).cornerRadius(4)
                        Text("\(self.viewModel.monthlyPaid) $").font(.body)
                    }
                }.padding(.all)

                /// region two
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loan amount").font(.headline)
                    
                    TextField("Input money", text: $viewModel.loanAmount , onEditingChanged: { _ in
                        print("$0onEditingChanged")
                        showShortcutView = true
                        
                    }, onCommit: {
                        print("onCommit")
                        
                    }).textFieldStyle(.roundedBorder).onAppear {
                        print("textFieldStyle onAppear")
                    }.keyboardType(.numberPad)
                    
                    HStack {
                        Spacer()
                        
                        Picker("shortcut money", selection: self.$viewModel.shortInputMoneySegment) {
                            Text(".000").tag(0)
                            Text(".000.000").tag(1)
                            Text(".000.000.000").tag(2)
                            Text("Clear").font(.caption).foregroundColor(.red).tag(3)
                        }.pickerStyle(.segmented)
                    }
                    
                }.padding([.leading, .trailing])
                
                /// region three
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loan term").font(.headline)
                    
                    HStack {
                        TextField("Input term", text:  $viewModel.loanTerm, onEditingChanged: { _ in
                            print("$0onEditingChanged")
                        }, onCommit: {
                            print("onCommit")
                        }).textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                        
                        Picker("What is your term?", selection: self.$viewModel.termSelect) {
                            Text("years").tag(0)
                            Text("months").tag(1)
                        }.pickerStyle(.segmented)
                    }
                    
                }.padding([.leading, .trailing])
                
                
                /// region four
                VStack(alignment: .leading, spacing: 10) {
                    Text("Interest rate").font(.headline)
                    
                    HStack {
                        TextField("Input rate", text:  $viewModel.interestRate, onEditingChanged: { _ in
                            print("$0onEditingChanged")
                        }, onCommit: {
                            print("onCommit")
                        }).textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                        
                        Label("%", image: "")
                        
                    }
                    
                }.padding([.leading, .trailing])
                
                ///
                ///cluster five
                ///
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Interest type").font(.headline)
                        
                        Button {
                            self.presentingModal = true
                        } label: {
                            Image(systemName: "info.square.fill")
                        }.sheet(isPresented: $presentingModal) {
                            NavigationLink(destination: DetailView()) {
                                TextView(text: self.$viewModel.textDescriptionMethod).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).font(.custom(
                                    "AmericanTypewriter",
                                    fixedSize: 33))
                            }.navigationBarTitle("Description method")
                        }
                        
                    }
                    
                    Picker("What is your term type", selection: self.$viewModel.interestType) {
                        Text("Flat rate method").tag(0)
                        Text("Reduce balance method").tag(1)
                    }.pickerStyle(.segmented)
                    
                }.padding([.leading, .trailing, .bottom])
                
                Spacer()
                
                ///
                ///Button
                ///
                VStack(alignment: .center) {
                    NavigationLink(destination: PrincipalDetailView()) {
                        Text("Result").frame(width: 300, height: 55).font(.headline).background(Color.red).cornerRadius(10.0).foregroundColor(Color.white)
                    }
                    
                }
                
            }.navigationTitle("Loan Calculator").background(Color.white)
        }
    }
}

struct CircularProgressView: View {
    //    @Binding var percentage: Double
    
    @ObservedObject var viewModel: CircularProgressViewModel
    
    var body: some View {
        GeometryReader { geo in
            Text("\(viewModel.percentage) %").frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .overlay(
                    ZStack {
                        Circle().stroke(Color.pink.opacity(0.5), lineWidth: 10).background(Color.clear)
                        Circle().trim(from: 0, to: viewModel.percentage / 100).stroke(Color.pink, style: StrokeStyle(lineWidth: 10, lineCap: .round)).rotationEffect(.degrees(-90))//.background(Color.pink)
                    }
                )
        }
        
    }
    
}

class CircularProgressViewModel: ObservableObject {
                                
    @Published var percentage: Double
    init(percentage: Double) {
        self.percentage = percentage
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
