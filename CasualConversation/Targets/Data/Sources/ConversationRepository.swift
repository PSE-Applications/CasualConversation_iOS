//
//  ConversationRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import CoreData

	public var fetchList: [Conversation] = [] // TODO: 처리 필요
	
}
public struct ConversationRepository: Dependency {
	
	public struct Dependency {
		let coreDataStack: CoreDataStackProtocol
		
		public init(coreDataStack: CoreDataStackProtocol) {
			self.coreDataStack = coreDataStack
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

// MARK: - Usa CoreDataRepository
extension ConversationRepository: ConversationRepositoryProtocol {
	
	public func fetchRequest() -> [Conversation]? {
	}
	public func create(_ item: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func update(after editedItem: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
