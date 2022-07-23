//
//  Note.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation.NSDate
import Common

public struct Note: UUIDIdentifiable {
	
	public static var empty: Self {
		.init(
			id: UUID(),
			original: "",
			translation: "",
			category: .vocabulary,
			references: [],
			createdDate: Date()
		)
	}
        
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
