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

// Visualize fret board
let strings = ["E", "A", "D", "G", "B", "E"]

// Show the notes on the fret board
// The fretMatrix is a 2D array of strings, where the first index is the string number and the second index is note letter
let fretMatrix = [
    ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"],
    ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"],
    ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"],
    ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"],
    ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
    ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"],
]

// Visualize the scale on the fret board
// Display six strings and highlight the selected note
// The fretboard should be a grid of lines and circles
// Only circle the first instance of the note on the fretboard
struct FretBoard: View {
    var scale: Scale
    var scaleNoteIndex: Int
    
    private func firstOccurrenceOfNote() -> (stringIndex: Int, fretIndex: Int)? {
            let targetNote = scale.notes[scaleNoteIndex]

            for (stringIndex, string) in fretMatrix.enumerated() {
                if let fretIndex = string.firstIndex(of: targetNote) {
                    return (stringIndex, fretIndex+1) // Return the first occurrence found
                }
            }
            return nil // No occurrence found
        }

        var body: some View {
            let firstOccurrence = firstOccurrenceOfNote() // Calculate this outside of the View's body

            VStack {
                ForEach(0..<7, id: \.self) { stringIndex in
                    HStack {
                        ForEach(0..<13, id: \.self) {
                            fretIndex in
                            
                            if (stringIndex == 6) {
                                if (fretIndex == 0) {
                                    Circle()
                                        .strokeBorder(Color.black, lineWidth: 0)
                                        .background(Circle().fill(Color.clear))
                                        .frame(width: 20, height: 20)
                                } else {
                                    // render a bunch of circles with a number in each
                                    Circle()
                                        .strokeBorder(Color.black, lineWidth: 0)
                                        .background(Circle().fill(Color.black))
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Text("\(fretIndex)").foregroundColor(Color.white)
                                        )
                                }
                            } else {
                                if (fretIndex == 0) {
                                    // Render circles with the note of the string
                                    Circle()
                                        .strokeBorder(Color.black, lineWidth: 1)
                                        .background(Circle().fill(Color.black))
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Text("\(strings[stringIndex])").foregroundColor(Color.white)
                                        )
                                } else {
                                    Circle()
                                        .strokeBorder(Color.black, lineWidth: 1)
                                        .background((firstOccurrence?.stringIndex == stringIndex && firstOccurrence?.fretIndex == fretIndex) ? Circle().fill(Color.blue) : Circle().fill(Color.clear))
                                        .frame(width: 20, height: 20)
                                }
                                
                            }
                            
                        }
                    }
                }
            }
            
            
        }
}

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
                
                FretBoard(scale: scale, scaleNoteIndex: scaleNoteIndex)
                Spacer()
            }
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
