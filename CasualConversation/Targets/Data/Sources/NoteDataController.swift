//
//  NoteDataController.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import CoreData

extension Note {
	
	init(entity: NSManagedObject) {
		self.init(
			id: entity.value(forKey: "id") as! Identifier,
			original: entity.value(forKey: "original") as! String,
			translation: entity.value(forKey: "translation") as! String,
			category: Category(rawValue: entity.value(forKey: "category") as! String)!,
			references: entity.value(forKey: "references") as! [Identifier],
			createdDate: entity.value(forKey: "createdDate") as! Date
		)
	}
	
	func setValues(_ entity: NSManagedObject) {
		entity.setValue(id, forKey: "id")
		entity.setValue(original, forKey: "original")
		entity.setValue(translation, forKey: "translation")
		entity.setValue(category.rawValue, forKey: "category")
		entity.setValue(references, forKey: "references")
		entity.setValue(createdDate, forKey: "createdDate")
	}
}

public struct NoteDataController: Dependency {
	
	static let entityName = "NoteEntity"
	
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
extension NoteDataController: NoteDataControllerProtocol {
	
	public func fetch(filter item: Conversation? = nil) -> [Note]? {
		let fetchRequest = NoteEntity.fetchRequest()
		let sortDescriptor = NSSortDescriptor.init(
			key: #keyPath(NoteEntity.createdDate),
			ascending: false
		)
		fetchRequest.sortDescriptors = [sortDescriptor]
		do {
			let list = try dependency.coreDataStack
				.mainContext.fetch(fetchRequest)
				.compactMap({ Note(entity: $0) })
			guard let itemID = item?.id else {
				return list
			}
			return list.filter({ $0.references.contains(itemID) })
		} catch {
			CCError.log.append(.persistenceFailed(reason: .coreDataUnloaded(error)))
			return nil
		}
	}
	
	public func create(_ item: Note, completion: (CCError?) -> Void) {
		let entity = NoteEntity(context: dependency.coreDataStack.mainContext)
		item.setValues(entity)
		self.dependency.coreDataStack.saveContext(completion: completion)
		completion(nil)
	}
	
	public func update(after editedItem: Note, completion: (CCError?) -> Void) {
		do {
			let objects = try dependency.coreDataStack.mainContext.fetch(NoteEntity.fetchRequest())
			guard let object = objects.first(where: { $0.id == editedItem.id }) else {
				completion(.persistenceFailed(reason: .coreDataUnloadedEntity))
				return
			}
			editedItem.setValues(object)
			self.dependency.coreDataStack.saveContext(completion: completion)
			completion(nil)
		} catch let error {
			completion(.persistenceFailed(reason: .coreDataUnloaded(error)))
		}
	}
	
	public func delete(_ item: Note, completion: (CCError?) -> Void) {
		do {
			let objects = try dependency.coreDataStack.mainContext.fetch(NoteEntity.fetchRequest())
			guard let object = objects.first(where: { $0.id == item.id }) else {
				completion(.persistenceFailed(reason: .coreDataUnloadedEntity))
				return
			}
			self.dependency.coreDataStack.mainContext.delete(object)
			self.dependency.coreDataStack.saveContext(completion: completion)
			completion(nil)
		} catch let error {
			completion(.persistenceFailed(reason: .coreDataUnloaded(error)))
		}
	}
	
}
