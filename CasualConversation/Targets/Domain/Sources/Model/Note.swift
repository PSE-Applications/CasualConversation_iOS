//
//  Note.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation.NSDate
import Common

public struct Note: UUIDIdentifiable {
        
    enum Category {
        case vocabulary
        case sentece
    }
    
	public let id: Identifier
    let original: String
    let translation: String
    let category: Category
	let references: [Identifier]
    let createdDate: Date
    
}
