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

extension Conversation {
	
	init(entity: NSManagedObject) {
		self.init(
			id: entity.value(forKey: "id") as! UUID,
			title: entity.value(forKey: "title") as? String,
			topic: entity.value(forKey: "topic") as? String,
			members: entity.value(forKey: "members") as! [String],
			recordFilePath: entity.value(forKey: "recordFilePath") as! URL,
			recordedDate: entity.value(forKey: "recordedDate") as! Date,
			pins: entity.value(forKey: "pins") as! [TimeInterval]
		)
	}
	
	func setValues(_ entity: NSManagedObject) {
		entity.setValue(id, forKey: "id")
		entity.setValue(title, forKey: "title")
		entity.setValue(topic, forKey: "topic")
		entity.setValue(members, forKey: "members")
		entity.setValue(recordFilePath, forKey: "recordFilePath")
		entity.setValue(recordedDate, forKey: "recordedDate")
		entity.setValue(pins, forKey: "pins")
	}
	
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
		let fetchRequest = ConversationEntity.fetchRequest()
		let sortDescriptor = NSSortDescriptor.init(
			key: #keyPath(ConversationEntity.recordedDate),
			ascending: true
		)
		fetchRequest.sortDescriptors = [sortDescriptor]
		do {
			let list = try dependency.coreDataStack
				.mainContext.fetch(fetchRequest)
				.compactMap({ Conversation(entity: $0) })
			return list
		} catch let error {
			debugPrint(CCError.persistenceFailed(reason: .coreDataUnloaded(error)))
			return nil
		}
	}
	
	public func create(_ item: Conversation, completion: (CCError?) -> Void) {
		let entity = ConversationEntity(context: dependency.coreDataStack.mainContext)
		item.setValues(entity)
		self.dependency.coreDataStack.saveContext()
		completion(nil)
	}
	
	public func update(after editedItem: Conversation, completion: (CCError?) -> Void) {
		do {
			let objects = try dependency.coreDataStack.mainContext.fetch(ConversationEntity.fetchRequest())
			guard let object = objects.first(where: { $0.id == editedItem.id }) else {
				completion(.persistenceFailed(reason: .coreDataUnloadedEntity))
				return
			}
			editedItem.setValues(object)
			self.dependency.coreDataStack.saveContext()
			completion(nil)
		} catch let error {
			completion(.persistenceFailed(reason: .coreDataUnloaded(error)))
		}
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		do {
			let objects = try dependency.coreDataStack.mainContext.fetch(ConversationEntity.fetchRequest())
			guard let object = objects.first(where: { $0.id == item.id }) else {
				completion(.persistenceFailed(reason: .coreDataUnloadedEntity))
				return
			}
			self.dependency.coreDataStack.mainContext.delete(object)
			self.dependency.coreDataStack.saveContext()
			completion(nil)
		} catch let error {
			completion(.persistenceFailed(reason: .coreDataUnloaded(error)))
		}
	}
	
}
