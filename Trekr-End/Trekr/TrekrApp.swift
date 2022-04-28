//
//  TrekrApp.swift
//  Trekr
//
//  Created by Paul Hudson on 22/12/2020.
//

import SwiftUI

@main
struct TrekrApp: App {
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            TabView {
                ListingView()
                    .tabItem {
                        Image(systemName: "airplane.circle.fill")
                        Text("Discover")
                    }

                TipsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Tips")
                    }
            }
            .environmentObject(dataController)
        }
    }
}
