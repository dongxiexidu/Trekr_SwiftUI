//
//  LocationView.swift
//  Trekr
//
//  Created by Paul Hudson on 22/12/2020.
//

import SwiftUI

extension Text {
    func headerStyle() -> some View {
        self
            .font(.title2)
            .foregroundColor(.secondary)
            .fontWeight(.black)
            .textCase(.uppercase)
    }
}

extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct LocationView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingMap = false

    let location: Location

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                LocationHeader(location: location)
            }

            VStack(alignment: .leading) {
                Text("Country: \(location.country)")
                    .headerStyle()

                Text(location.description)
                    .padding(.bottom)

                Text("Did you know?")
                    .headerStyle()

                Text(location.more)
                    .padding(.bottom)

                Text("Travel advisories")
                    .headerStyle()

                Text(location.advisory)

                HStack {
                    Spacer()

                    Button(dataController.isFavorite(location) ? "Remove Favorite" : "Add Favorite", action: toggleFavorite)
                        .buttonStyle(PrimaryButtonStyle())

                    Button("Show on Map", action: showOnMap)
                        .buttonStyle(PrimaryButtonStyle())

                    Spacer()
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .navigationTitle(location.name)
        .sheet(isPresented: $showingMap) {
            WorldView(location: location)
        }
    }

    func toggleFavorite() {
        dataController.toggleFavorite(location)
    }

    func showOnMap() {
        showingMap = true
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationView(location: Location.example)
                .environmentObject(DataController())
        }
    }
}
