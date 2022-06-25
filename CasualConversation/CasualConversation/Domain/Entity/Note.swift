//
//  Note.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation

struct Note: Identifiable {
    
    typealias Identifier = UUID
    
    enum Category {
        case vocabulary
        case sentece
    }
    
    let id: Identifier
    let original: String
    let translation: String
    let category: Category
    let references: [Identifier]
    let date: Data
    
}
