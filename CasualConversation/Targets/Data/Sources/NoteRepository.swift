//
//  NoteRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import CoreData

public struct NoteRepository: Dependency {
	
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

extension NoteRepository: NoteRepositoryProtocol {
	
	public var fetchList: [Note] {
		[] // TODO: 처리 필요
	}
	
	public func create(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func update(after editedItem: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
}
