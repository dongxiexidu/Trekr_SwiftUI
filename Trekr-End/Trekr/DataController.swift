//
//  DataController.swift
//  Trekr
//
//  Created by Paul Hudson on 16/01/2021.
//

import Foundation

class DataController: ObservableObject {
    @Published private var favorites: Set<String>
    let locations: [Location]

    var primary: Location {
        locations[0]
    }

    init() {
        let savedValues = UserDefaults.standard.stringArray(forKey: "Favorites") ?? []
        favorites = Set(savedValues)

        guard let url = Bundle.main.url(forResource: "locations", withExtension: "json") else {
            fatalError("Can't locate locations.json in the app bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can't load locations.json from the app bundle.")
        }

        guard let decoded = try? JSONDecoder().decode([Location].self, from: data) else {
            fatalError("Can't decode locations.json from the app bundle.")
        }

        locations = decoded.sorted { $0.name < $1.name }
    }

    func isFavorite(_ location: Location) -> Bool {
        favorites.contains(location.name)
    }

    func toggleFavorite(_ location: Location) {
        if favorites.contains(location.name) {
            favorites.remove(location.name)
        } else {
            favorites.insert(location.name)
        }

        UserDefaults.standard.set(Array(favorites), forKey: "Favorites")
    }
}
