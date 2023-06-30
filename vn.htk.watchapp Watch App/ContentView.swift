//
//  ContentView.swift
//  vn.htk.watchapp Watch App
//
//  Created by Viet Nguyen on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    var quote: String {
        return ContentViewModel.quote?.words ?? "Something like that."
    }
    
    var author: String {
        return "--" + (ContentViewModel.quote?.author ?? "Noname")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Text(quote).font(.title).foregroundColor(.red).bold().lineLimit(nil)
                    Text(author).font(.caption).foregroundColor(.white)
                }.padding()
            }.navigationTitle("Have a good day!")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
