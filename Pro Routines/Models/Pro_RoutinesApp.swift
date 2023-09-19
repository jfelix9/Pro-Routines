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
    
    var body: some Scene {
        WindowGroup {
            RoutinesListView(routines: $routines)
        }
    }
}
