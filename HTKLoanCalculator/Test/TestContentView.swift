//
//  TestContentView.swift
//  HTKLoanCalculator
//
//  Created by LDCC Macbook Pro on 25/08/2023.
//

import SwiftUI

struct TestContentView: View {
    @State var events: Array<Event>?
    @State var angle: Double = 30.0
    @State var isAnimation: Bool = true
    
    var foreverAnimation: Animation {
            Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: true)
        }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                List {
                    ForEach(self.events ?? []) { element in
                        Text(element.mota)
                    }
                }
                
            }.toolbar {
                Text("Fetch")
                    .padding(.all)
                    .foregroundColor(.black)
                    .background(content: {
                        LinearGradient(colors: [.red, .green, .blue], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
                    })
                    .onTapGesture {
                        print("on tap hello world")
                        let url = URL(string: Constant.urlEventsTest)
                        let urlRequest = URLRequest(url: url!)
                        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                            if (error != nil) {
                                print("[DB] \(error?.localizedDescription)")
                                return
                            }
                            do {
                                let jsonRes = try JSONSerialization.jsonObject(with: data!, options: .json5Allowed)
                                print("[RES] \(String(describing: data))")
                                print(jsonRes)
                                
                                let decoder = JSONDecoder()
                                let object = try decoder.decode(AEvent.self, from: data!)
                                print(object.apple_events.first?.mota)
                                
                                self.events = object.apple_events
                            } catch (let haveError) {
                                print("[DB] \(haveError.localizedDescription)")
                            }
                        }.resume()
                    }
                    .rotationEffect(Angle(degrees: self.isAnimation ? self.angle : 0.0))
                    .onAppear {
                        withAnimation(self.foreverAnimation) {
                            self.angle += 360.0
                        }
                    }
                
                Button("About") {
                    print("About")
                }
                
                Button("Help") {
                    print("Help")
                }
            }
            
        }
        
    }
        
}

struct ChatMessageCell: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .aspectRatio(1.0, contentMode: .fill)
            Text("This is a chat message of certain length to try to force a wrap in the preview.")
        }.background {
            Color.clear
        }
    }
}

struct OverlayChatView: View {
    var body: some View {
        ZStack {
            Color.blue
            List(0 ..< 5) { item in
                ChatMessageCell().background {
                    Color.clear
                }
            }
            .background(Color.clear)
        }.background {
            Color.red
        }
    }
}

//struct TestContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        TestContentView().background(Color.clear)
//        TestContentView()
//    }
//}

struct Event: Decodable, Identifiable {
    var id = UUID()
    
    let mota: String
    
    enum CodingKeys: String, CodingKey {
        case mota = "description"
    }
}


struct AEvent: Decodable {
    let apple_events: Array<Event>
}

struct AAEvent: Decodable {
    let y2023: Array<Event>
}
