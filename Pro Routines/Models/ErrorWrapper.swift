//
//  ErrorWrapper.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/21/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    var error: Error
    var guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
