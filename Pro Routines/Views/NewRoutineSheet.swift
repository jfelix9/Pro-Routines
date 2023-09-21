//
//  NewRoutineSheet.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct NewRoutineSheet: View {
    @State private var newRoutine = ProRoutine.emptyRoutine
    @Binding var routines: [ProRoutine]
    @Binding var isPresentingNewRoutineView: Bool
    
    var body: some View {
        NavigationStack {
            RoutineConfigView(routine: $newRoutine)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewRoutineView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            routines.append(newRoutine)
                            isPresentingNewRoutineView = false
                        }
                    }
                }
        }
    }
}

struct NewRoutineSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewRoutineSheet(routines: .constant(ProRoutine.sampleData), isPresentingNewRoutineView: .constant(true))
    }
}
