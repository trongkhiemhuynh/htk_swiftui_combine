//
//  MainView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 5/23/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                customeView
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: "homekit").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/5, height: 30)
                            .padding(.top, 4)
                        Text("Home").font(.footnote).padding(.bottom, 4)
                    }.onTapGesture {
                        tabbarRouter.currentPage = .home
                    }
                    
                    VStack {
                        Image(systemName: "map.fill").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/5, height: 33)
                            .padding(.top, 4)
                        Text("Map").font(.footnote).padding(.bottom, 4)
                    }.onTapGesture {
                        tabbarRouter.currentPage = .map
                    }
                    
                    VStack {
                        Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/5, height: 33)
                            .padding(.top, 4)
                        Text("Todo").font(.footnote).padding(.bottom, 4)
                    }.onTapGesture {
                        tabbarRouter.currentPage = .plus
                    }
                    
                    VStack {
                        Image(systemName: "video.circle.fill").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/5, height: 33)
                            .padding(.top, 4)
                        Text("Videos").font(.footnote).padding(.bottom, 4)
                    }.onTapGesture {
                        tabbarRouter.currentPage = .videos
                    }
                    
                    VStack {
                        Image(systemName: "person.crop.circle").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/5, height: 33)
                            .padding(.top, 4)
                        Text("Profile").font(.footnote).padding(.bottom, 4)
                    }.onTapGesture {
                        tabbarRouter.currentPage = .profile
                    }
                    
                }.frame(width: geometry.size.width, height: 70).background(Color.gray.opacity(0.2))
            }
            
        }.navigationTitle("Loan Calculator").navigationBarTitleDisplayMode(.automatic).background(Color.white)
    }
        
    @ViewBuilder var customeView: some View {
        switch tabbarRouter.currentPage {
        case .home:
            NavigationView {
                LoanView(viewModel: LoanViewModel())
            }
        case .map:
            MapView().background(Color.purple)
        case .plus:
            ImageProcessingView()
        case .videos:
            VideoView().background(.green)
        case .profile:
            ProfileView().background(.yellow)
        }
    }
    
    @ObservedObject var tabbarRouter: TabBarRouter
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(tabbarRouter: TabBarRouter())
    }
}

/// TestView
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
                Image(systemName: "info.square.fill").resizable().frame(width: 50, height: 50)
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
