//
//  Scale.swift
//  guitar
//
//  Created by Harsha Somisetty on 2/24/24.
//

import Foundation
import RealityKit
import RealityKitContent
import SwiftUI

struct Scale: Identifiable {
    var id = UUID()
    var name: String
    var notes: [String]
}

// Create sample scales
let scales = [
    Scale(name: "Major", notes: ["C", "D", "E", "F", "G", "A", "B"]),
    Scale(name: "Minor", notes: ["C", "D", "Eb", "F", "G", "Ab", "Bb"]),
    Scale(name: "Pentatonic", notes: ["C", "D", "E", "G", "A"]),
]

// Show the scale name on top
// Then start with the first note of the scale large in the center, and when the user taps on it, move to the next note

var scaleNoteIndex = 0

struct ScaleDetail: View {
    var scale: Scale
    @State private var scaleNoteIndex = 0
    var body: some View {
            VStack {
                Text(scale.name)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                // Use scaleNoteIndex to display the current note
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text(scale.notes[scaleNoteIndex])
                            .font(.extraLargeTitle)
                    )
                    .onTapGesture {
                        scaleNoteIndex = (scaleNoteIndex + 1) % scale.notes.count
                    }
                
                Spacer()
            }.gesture(TapGesture().onEnded { _ in
                scaleNoteIndex = (scaleNoteIndex + 1) % scale.notes.count
            })
        }
}

struct ScaleView: View {
    var body: some View {
//        show the scales to choose from
        NavigationView {
            List(scales) { scale in
                NavigationLink(destination: ScaleDetail(scale: scale)) {
                    Text(scale.name)
                }
            }
            .navigationTitle("Scales")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ScaleView()
}
