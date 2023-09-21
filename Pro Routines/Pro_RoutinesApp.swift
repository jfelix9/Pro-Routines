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
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            RoutinesListView(routines: $store.routines) {
                Task {
                    do {
                        try await store.save(routines: store.routines)
                    } catch {
//                        fatalError(error.localizedDescription)
                        errorWrapper = ErrorWrapper(error: error, guidance: "There was an error in saving the app data.")
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
//                        fatalError(error.localizedDescription)
                        errorWrapper = ErrorWrapper(error: error, guidance: "There was an error in loading the app data.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.routines = ProRoutine.sampleData
                } content: { wrapper in
                        ErrorView(errorWrapper: wrapper)
                }
        }
    }
}
