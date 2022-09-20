//
//  TestCoreDataStack.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/07/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data
@testable import Common
import CoreData

struct TestCoreDataStack {
	
	private let testableStoreContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(
			name: CoreDataStack.modelName,
			managedObjectModel: CoreDataStack.model
		)
		container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
}

extension TestCoreDataStack: CoreDataStackProtocol {
	
	public var mainContext: NSManagedObjectContext {
		self.testableStoreContainer.viewContext
	}
	
	public func saveContext(completion: (CCError?) -> Void) {
		guard mainContext.hasChanges else {
			return
		}
		
		do {
			try mainContext.save()
			completion(nil)
		} catch let error as NSError {
			completion(.persistenceFailed(reason: .coreDataViewContextUnsaved(error)))
		}
	}
	
	public func entityDescription(forEntityName: String) -> NSEntityDescription? {
		NSEntityDescription.entity(
			forEntityName: forEntityName,
			in: self.mainContext
		)
	}
	
}
