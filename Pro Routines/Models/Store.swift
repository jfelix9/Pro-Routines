//
//  Store.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/21/23.
//

import Foundation

@MainActor
class Store: ObservableObject {
    @Published var routines: [ProRoutine] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("routines.data")
    }
    
    func load() async throws {
        let task = Task<[ProRoutine], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return [] }
            let proRoutinesData = try JSONDecoder().decode([ProRoutine].self, from: data)
            return proRoutinesData
        }
        let routines = try await task.value
        self.routines = routines
    }
    
    func save(routines: [ProRoutine]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(routines)
            let file = try Self.fileURL()
            try data.write(to: file)
        }
        _ = try await task.value
    }
}
