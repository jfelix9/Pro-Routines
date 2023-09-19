//
//  RoutinePreView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutinePreView: View {
    let routine: ProRoutine
    var body: some View {
        VStack(alignment: .leading) {
            Text(routine.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(routine.tasks.count)", systemImage: "checklist")
                    .accessibilityLabel("\(routine.tasks.count) tasks")
                Spacer()
                Label("\(routine.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(routine.lengthInMinutes) minutes")
            }
        }
        .padding()
        .foregroundColor(routine.theme.accentColor)
    }
}

struct RoutinePreView_Previews: PreviewProvider {
    static var sampleRoutine = ProRoutine.sampleData[0]
    static var previews: some View {
        RoutinePreView(routine: sampleRoutine)
            .background(sampleRoutine.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
