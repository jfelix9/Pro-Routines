//
//  ContentView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutineActionView: View {
    var body: some View {
        VStack {
            Text("Hello, world! This is Pro Routine!")
            ProgressView(value: 10, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Label("0:00", systemImage: "hourglass.tophalf.filled")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Label("0:00", systemImage: "hourglass.bottomhalf.filled")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("0 minutes")
            Circle()
                .strokeBorder(lineWidth: 24)
            HStack {
                Text("Task 1")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next Task")
            }
        }
        .padding()
    }
}

struct RoutineActionView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineActionView()
    }
}
