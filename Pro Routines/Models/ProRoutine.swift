//
//  ProRoutine.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import Foundation

struct ProRoutine {
    var title: String
    var tasks: [String]
    var lengthInMinutes: Int
    var theme: Theme
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
