//
//  guitApp.swift
//  guit
//
//  Created by Harsha Somisetty on 2/24/24.
//

import SwiftUI

@main
struct guitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
