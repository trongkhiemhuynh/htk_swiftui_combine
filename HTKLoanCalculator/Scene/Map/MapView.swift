//
//  MapView.swift
//  HTKLoanCalculator
//
//  Created by Viet Nguyen on 7/5/23.
//

//MARK: Some marker location favorites, search location

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.7814503, longitude: 106.6525954), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, interactionModes: [.zoom, .pan], showsUserLocation: true, userTrackingMode: nil).edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
