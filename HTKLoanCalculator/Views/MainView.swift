//
//  MainView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 5/23/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
//        NavigationView {
//                HStack {
//                    TestView()
//                    TestView()
//                }.background(Color.blue).edgesIgnoringSafeArea(.bottom)
                GeometryReader { geometry in
                    VStack {
                    Spacer()
                    customeView
                    Spacer()
                    
                    HStack {
                        VStack {
                            Image(systemName: "homekit").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/5, height: 33)
                                .padding(.top, 10)
                            Text("Home")
                            Spacer()
                        }.onTapGesture {
                            tabbarRouter.currentPage = .home
                        }
                        
                        VStack {
                            Image(systemName: "map.fill").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/5, height: 33)
                                .padding(.top, 10)
                            Text("Map")
                            Spacer()
                        }.onTapGesture {
                            tabbarRouter.currentPage = .map
                        }
                        
                        VStack {
                            Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/5, height: 33)
                                .padding(.top, 10)
                            Text("Add")
                            Spacer()
                        }
                        
                        VStack {
                            Image(systemName: "video.circle.fill").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/5, height: 33)
                                .padding(.top, 10)
                            Text("Videos")
                            Spacer()
                        }
                        
                        VStack {
                            Image(systemName: "person.crop.circle").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/5, height: 33)
                                .padding(.top, 10)
                            Text("Profile").font(.footnote)
                            Spacer()
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height/8).background(Color.blue.shadow(radius: 2))
                    }.background(Color.red).edgesIgnoringSafeArea(.bottom)

            }.navigationTitle("Loan Calculator").navigationBarTitleDisplayMode(.automatic).background(Color.white)
            
        }
        
    @ViewBuilder var customeView: some View {
        switch tabbarRouter.currentPage {
        case .home:
            NavigationView {
//                List(items, id: \.self) {
//                    Text($0)
//                }
//                .navigationBarTitle(Text("Today's Flavors"))
                LoanView(viewModel: MainViewModel())
            }
        case .map:
            Text("m")
        case .plus:
            Text("h")
        case .videos:
            Text("h")
        case .profile:
            Text("h")
        }
    }
    
    @ObservedObject var tabbarRouter: TabBarRouter
        
    let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip", "Pistachio"]
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(tabbarRouter: TabBarRouter())
    }
}

struct TestView: View {
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Text("Hello SwiftUI!").background(LinearGradient(colors: [.red, .green, .blue], startPoint: .leading, endPoint: .trailing)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100).onTapGesture {
                print("tap tap")
            }
            Button {
                print("aaa", self.count)
                self.count += 1
            } label: {
                Text("click me !!!!!").foregroundColor(.white)
            }
            Image(systemName: "clock").frame(width: 100, height: 30, alignment: .center).background(Color.brown)
            
            Button (action: {
                
            }) {
                Image(systemName: "arrowtriangle.down.fill").resizable().frame(width: 50, height: 50)
            }
        }

    }
}

class TabBarRouter: ObservableObject {
    enum Page {
        case home
        case map
        case videos
        case profile
        case plus
    }
    
    @Published var currentPage: Page = .home
    
}
