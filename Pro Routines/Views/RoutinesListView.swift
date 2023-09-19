//
//  RoutinesListView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutinesListView: View {
    let routines: [ProRoutine]
    
    var body: some View {
        NavigationStack {
            List(routines) { i in
                NavigationLink(destination: RoutineDetailView(routine: i)) {
                    RoutinePreView(routine: i)
                }
                .listRowBackground(i.theme.mainColor)
            }
            .navigationTitle("Routines")
            .toolbar {
                Button(action: {
                    // TODO: add function to add routine to routines array
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("add new routine")
            }
        }
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView(routines: ProRoutine.sampleData)
    }
}
