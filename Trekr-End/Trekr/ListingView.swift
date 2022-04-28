//
//  ListingView.swift
//  Trekr
//
//  Created by Paul Hudson on 16/01/2021.
//

import SwiftUI

struct ListingRow: View {
    let location: Location

    var body: some View {
        NavigationLink(destination: LocationView(location: location)) {
            Image(location.country)
                .resizable()
                .frame(width: 80, height: 40)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.black,   lineWidth: 1)
                )

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)

                Text(location.country)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
}

struct ListingView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingFavorites = false

    var items: [Location] {
        if showingFavorites {
            return dataController.locations.filter(dataController.isFavorite)
        } else {
            return dataController.locations
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose your destination")) {
                    ForEach(items, content: ListingRow.init)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Discover")
            .toolbar {
                favoritesButton
            }
        }
    }

    var favoritesButton: some View {
        Button(action: toggleFavorites) {
            if showingFavorites {
                Text("Show all locations")
            } else {
                Text("Show only favorites")
            }
        }
    }

    func toggleFavorites() {
        withAnimation {
            showingFavorites.toggle()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
            .environmentObject(DataController())
    }
}
