//
//  ContentView.swift
//  guit
//
//  Created by Harsha Somisetty on 2/24/24.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct DetailView: View {
    var body: some View {
        Text("This is the detail view")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Show Scale View") {
                    ScaleView()
                }
                NavigationLink("Show Song View") {
                    SongView()
                }
            }
            .navigationTitle("Navigation")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
