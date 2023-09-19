//
//  Theme.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/19/23.
//

import SwiftUI

enum Theme: String {
    case morning
    case night
    case scrum
    case study
    
    var accentColor: Color {
        switch self {
        case .morning, .scrum: return .black
        case .night, .study: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
}
