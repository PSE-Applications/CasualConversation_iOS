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
	
	private var dataSource: [Conversation] = []
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

	private func fetchDataSource() {
		guard let list = dependency.repository.fetchRequest() else {
			return
		}
		self.dataSource = list
	}
}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	public func add(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.create(item, completion: completion)
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public var list: [Conversation] {
		self.dataSource
	}
	
	public func edit(after editedItem: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.update(after: editedItem, completion: completion)
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}
	
}
