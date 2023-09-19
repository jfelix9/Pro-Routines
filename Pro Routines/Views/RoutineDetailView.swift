//
//  DetailView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutineDetailView: View {
    @Binding var routine: ProRoutine
    
    @State private var isPresentingEditView = false
    @State private var editingRoutine = ProRoutine.emptyRoutine
    
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
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingRoutine = routine
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                RoutineConfigView(routine: $editingRoutine)
                    .navigationTitle(routine.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                routine = editingRoutine
                            }
                        }
                    }
            }
        }
    }
}

struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RoutineDetailView(routine: .constant(ProRoutine.sampleData[0]))
        }
    }
}
