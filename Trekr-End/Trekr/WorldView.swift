//
//  WorldView.swift
//  Trekr
//
//  Created by Paul Hudson on 16/01/2021.
//

import MapKit
import SwiftUI

struct WorldView: View {
    private let region: MKCoordinateRegion
    private let annotations: [Location]

    init(location: Location) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        )

        annotations = [location]
    }

    var body: some View {
        Map(coordinateRegion: .constant(region), interactionModes: [], annotationItems: annotations) { location in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
        }
        .ignoresSafeArea()
        .navigationTitle("Locations")
    }
}

struct WorldView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView(location: Location.example)
    }
}
