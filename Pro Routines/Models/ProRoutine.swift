//
//  ProRoutine.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import Foundation

struct ProRoutine: Identifiable {
    let id: UUID
    var title: String
    var tasks: [String]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, tasks: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.tasks = tasks
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}


extension ProRoutine {
    static let sampleData: [ProRoutine] =
    [
        ProRoutine(title: "Morning Routine",
                   tasks: ["Shower", "Dress", "Eat Breakfast", "Feed Dog"],
                   lengthInMinutes: 10,
                   theme: .morning),
        ProRoutine(title: "Night Routine",
                   tasks: ["Shower", "Pun on PJ's", "Brush Teeth", "Skincare", "Refill Waterbottle"],
                   lengthInMinutes: 5,
                   theme: .night),
        ProRoutine(title: "Morning Standup Meeting",
                   tasks: ["Dante", "Zack", "Logan", "Jared"],
                   lengthInMinutes: 5,
                   theme: .scrum)
    ]
}
