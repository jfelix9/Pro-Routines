//
//  Watchdog.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import Foundation

@MainActor
final class Watchdog: ObservableObject {
    @Published var currentRunner = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    
    struct Runner: Identifiable {
        let name: String
        var isCompleted: Bool
        let id = UUID()
    }
    
    private(set) var runners: [Runner] = []

    private(set) var lengthInMinutes: Int
    var runnerChangedAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerRunner: Int {
        (lengthInMinutes * 60) / runners.count
    }
    private var secondsElapsedForCurrentRunner: Int = 0
    private var runnerIndex: Int = 0
    private var runnerText: String {
        return "Runner \(runnerIndex + 1): " + runners[runnerIndex].name
    }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, tasks: [ProRoutine.Task] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.runners = tasks.runners
        secondsRemaining = lengthInSeconds
        currentRunner = runnerText
    }
    
    func startRunning() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToRunner(at: 0)
    }
    
    func stopRunning() {
        timer?.invalidate()
        timerStopped = true
    }
    
    nonisolated func skipRunner() {
        Task { @MainActor in
            changeToRunner(at: runnerIndex + 1)
        }
    }

    private func changeToRunner(at index: Int) {
        if index > 0 {
            let previousRunnerIndex = index - 1
            runners[previousRunnerIndex].isCompleted = true
        }
        secondsElapsedForCurrentRunner = 0
        guard index < runners.count else { return }
        runnerIndex = index
        currentRunner = runnerText

        secondsElapsed = index * secondsPerRunner
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }

    nonisolated private func update() {

        Task { @MainActor in
            guard let startDate,
                  !timerStopped else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForCurrentRunner = secondsElapsed
            self.secondsElapsed = secondsPerRunner * runnerIndex + secondsElapsedForCurrentRunner
            guard secondsElapsed <= secondsPerRunner else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

            if secondsElapsedForCurrentRunner >= secondsPerRunner {
                changeToRunner(at: runnerIndex + 1)
                runnerChangedAction?()
            }
        }
    }
    
    func reset(lengthInMinutes: Int, tasks: [ProRoutine.Task]) {
        self.lengthInMinutes = lengthInMinutes
        self.runners = tasks.runners
        secondsRemaining = lengthInSeconds
        currentRunner = runnerText
    }
}

extension Array<ProRoutine.Task> {
    var runners: [Watchdog.Runner] {
        if isEmpty {
            return [Watchdog.Runner(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { Watchdog.Runner(name: $0.name, isCompleted: false) }
        }
    }
}
