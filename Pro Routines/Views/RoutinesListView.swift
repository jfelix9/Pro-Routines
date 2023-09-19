//
//  RoutinesListView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutinesListView: View {
    @Binding var routines: [ProRoutine]
    @State private var isPresentingNewScrumView = false
    
    var body: some View {
        NavigationStack {
            List($routines) { $i in
                NavigationLink(destination: RoutineDetailView(routine: $i)) {
                    RoutinePreView(routine: i)
                }
                .listRowBackground(i.theme.mainColor)
            }
            .navigationTitle("Routines")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("add new routine")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewRoutineSheet(routines: $routines, isPresentingNewRoutineView: $isPresentingNewScrumView)
        }
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView(routines: .constant(ProRoutine.sampleData))
    }
}
