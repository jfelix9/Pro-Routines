//
//  RoutineConfigView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

struct RoutineConfigView: View {
    @Binding var routine: ProRoutine
    @State private var newTaskName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $routine.title)
                HStack {
                    Slider(value: $routine.lengthInMinutesAsDouble, in: 5...20, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(routine.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(routine.lengthInMinutes)")
                        .accessibilityHidden(true)
                }
                Picker("Theme", selection: $routine.theme) {
                    ForEach(Theme.allCases, id: \.self) {
                        Text(String("\($0)"))
                    }
                }
            }
            Section(header: Text("Tasks")) {
                ForEach(routine.tasks) { t in
                    Text(t.name)
                }
                .onDelete { i in
                    routine.tasks.remove(atOffsets: i)
                }
                HStack {
                    TextField("New Task", text: $newTaskName)
                    Button(action: {
                        withAnimation {
                            let newTask = ProRoutine.Task(name: newTaskName)
                            routine.tasks.append(newTask)
                            newTaskName = ""
                        }

                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add task")
                    }
                    .disabled(newTaskName.isEmpty)

                }

            }
        }
    }
}

struct RoutineConfigView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineConfigView(routine: .constant(ProRoutine.sampleData[0]))
    }
}
