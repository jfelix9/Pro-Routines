//
//  RoutineActionView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI
import AVFoundation

struct RoutineActionView: View {
    @Binding var routine: ProRoutine
    @StateObject var taskRunners = Watchdog()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    private var totalSeconds: Int {
        taskRunners.secondsElapsed + taskRunners.secondsRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(taskRunners.secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        taskRunners.secondsRemaining / 60
    }
    
    private var runnerNumber: Int? {
        guard let index = taskRunners.runners.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    private var isLastRunner: Bool {
        return taskRunners.runners.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var runnerText: String {
        guard let runnerNumber = runnerNumber else { return "No more tasks" }
        return "Task \(runnerNumber) of \(taskRunners.runners.count)"
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Label("\(taskRunners.secondsElapsed)", systemImage: "hourglass.tophalf.filled")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Label("\(taskRunners.secondsRemaining)", systemImage: "hourglass.bottomhalf.filled")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("0 minutes")
            Circle()
                .strokeBorder(lineWidth: 24)
            
            if isLastRunner {
                Text("Last Task")
            } else {
                HStack {
                    Text(runnerText)
                    Spacer()
                    Button(action: {
                        taskRunners.skipRunner()
                    }) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Task")
                }
            }
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            taskRunners.reset(lengthInMinutes: routine.lengthInMinutes, tasks: routine.tasks)
            taskRunners.runnerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            taskRunners.startRunning()
        }
        .onDisappear {
            taskRunners.stopRunning()
        }
    }
}

struct RoutineActionView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineActionView(routine: .constant(ProRoutine.sampleData[0]))
    }
}
