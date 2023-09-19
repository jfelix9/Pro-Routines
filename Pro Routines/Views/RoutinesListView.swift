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
        List(routines) {
            RoutinePreView(routine: $0)
                .listRowBackground($0.theme.mainColor)
        }
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView(routines: ProRoutine.sampleData)
    }
}
