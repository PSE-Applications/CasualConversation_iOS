//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL


public protocol ConversationManagable: ConversationRecodable, ConversationMaintainable { }

public protocol ConversationRecodable {
	func add(_ item: Conversation, completion: (CCError?) -> Void)
}

public protocol ConversationMaintainable {
	var list: [Conversation] { get }
	func edit(after editedItem: Conversation, completion: (CCError?) -> Void)
	func delete(_ item: Conversation, completion: (CCError?) -> Void)
}

public final class ConversationUseCase: Dependency, ConversationManagable {
	
	public struct Dependency {
		let repository: ConversationRepositoryProtocol
		
		public init(repository: ConversationRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	private func createConversation(with filePath: URL, completion: (CCError?) -> Void) {
		let recordedDate = Date()
		let newItem: Conversation = .init(
			id: UUID(),
			title: recordedDate.description,
			members: [],
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: []
		)
		self.dependency.repository.add(newItem, completion: completion)
	}
	
	public func add(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.add(item, completion: completion)
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public var list: [Conversation] {
		self.dependency.repository.list
	}
	
	public func edit(after editedItem: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.edit(after: editedItem, completion: completion)
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}
	
}
