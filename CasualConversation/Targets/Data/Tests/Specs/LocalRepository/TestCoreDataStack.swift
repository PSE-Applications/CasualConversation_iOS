//
//  TestCoreDataStack.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/07/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Data
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
	
	public func saveContext () {
		guard mainContext.hasChanges else {
//			print("--> \(#function) \(mainContext.hasChanges) guard")
			return
		}
		
		do {
			try mainContext.save()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
	
	public func entityDescription(forEntityName: String) -> NSEntityDescription? {
		NSEntityDescription.entity(
			forEntityName: forEntityName,
			in: self.mainContext
		)
	}
	
}