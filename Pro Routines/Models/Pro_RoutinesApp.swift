//
//  Pro_RoutinesApp.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

@main
struct Pro_RoutinesApp: App {
    @State private var routines = ProRoutine.sampleData
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            RoutinesListView(routines: $store.routines) {
                Task {
                    do {
                        try await store.save(routines: store.routines)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
