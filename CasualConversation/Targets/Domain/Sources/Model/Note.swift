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
        
	public enum Category: String {
        case vocabulary
        case sentence
    }
    
	public let id: Identifier
	public let original: String
	public let translation: String
	public let category: Category
	public let references: [Identifier]
	public let createdDate: Date
	
	public init(
		id: Identifier,
		original: String,
		translation: String,
		category: Category,
		references: [Identifier],
		createdDate: Date
	) {
		self.id = id
		self.original = original
		self.translation = translation
		self.category = category
		self.references = references
		self.createdDate = createdDate
	}
	
	public var isDone: Bool {
		!self.original.isEmpty && !self.translation.isEmpty
	}
    
}
