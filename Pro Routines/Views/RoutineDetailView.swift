//
//  DetailView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutineDetailView: View {
    let routine: ProRoutine
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: RoutineActionView()) {
                    Label("Start Routine", systemImage: "timer")
                        .font(.headline)
                }
            }
            Section(header: Text("Details")) {
                HStack {
                    Label("Lenght", systemImage: "clock")
                    Spacer()
                    Text("\(routine.lengthInMinutes)")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(routine.theme.name)")
                }
            }
            Section(header: Text("Tasks")) {
                ForEach(routine.tasks) {
                    Label($0.name, systemImage: "checkmark")
                }
            }
        }
        .navigationTitle(routine.title)
    }
}

struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RoutineDetailView(routine: ProRoutine.sampleData[0])
        }
    }
}
