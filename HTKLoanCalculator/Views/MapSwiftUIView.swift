//
//  MapSwiftUIView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 6/8/23.
//

import SwiftUI
import MapKit
//import SwiftData
// 10.7299546,106.7250793,
struct MapSwiftUIView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.7299546, longitude: 106.7250793), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationView {
            Map(coordinateRegion: $region).frame(width: .infinity, height: 300).navigationTitle("hello").onTapGesture {
                print("boom")
            }
        }
        
    }
}

struct MapSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapSwiftUIView()
    }
}
