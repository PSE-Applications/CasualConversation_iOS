//
//  CoreDataRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import CoreData

public protocol CoreDataStackProtocol {
	var mainContext: NSManagedObjectContext { get }
	func saveContext(completion: (CCError?) -> Void)
}

public final class CoreDataStack {
	
	public static let modelName = "CasualConversation"
	public static let model: NSManagedObjectModel = {
		guard let modelURL = Bundle(for: CoreDataStack.self).url(forResource: modelName, withExtension: "momd") else {
			fatalError("NSManagedObjectModel 생성을 위한 momd 파일 검색 실패")
		}
		guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("NSManagedObjectModel 생성실패")
		}
		return objectModel
	}()
	
	private let storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(
			name: CoreDataStack.modelName,
			managedObjectModel: CoreDataStack.model
		)
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	public init() {}

}

extension CoreDataStack: CoreDataStackProtocol {
	
	public var mainContext: NSManagedObjectContext {
		self.storeContainer.viewContext
	}
	
	public func saveContext(completion: (CCError?) -> Void) {
		guard mainContext.hasChanges else { return }
		
		do {
			try mainContext.save()
		} catch let error as NSError {
			completion(.persistenceFailed(reason: .coreDataViewContextUnsaved(error)))
		}
		completion(nil)
	}
	
//	public func entityDescription(forEntityName: String) -> NSEntityDescription? {
//		NSEntityDescription.entity(
//			forEntityName: forEntityName,
//			in: self.mainContext
//		)
//	}
	
}
