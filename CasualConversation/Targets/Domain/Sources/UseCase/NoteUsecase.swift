//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

public protocol NoteManagable {
	var list: [Note] { get }
	func add(item: Note, completion: (CCError?) -> Void)
	func edit(newItem: Note, completion: (CCError?) -> Void)
	func delete(item: Note, completion: (CCError?) -> Void)
}

public final class NoteUseCase: Dependency {
	
	public enum Filter {
		case all
		case selected(Conversation)
	}
	
	public struct Dependecy {
		let repository: NoteRepositoryProtocol
		var filter: Filter
		
		public init(
			repository: NoteRepositoryProtocol,
			filter: Filter
		) {
			self.repository = repository
			self.filter = filter
		}
	}
	
	public var dependency: Dependecy
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
	public func changeFilter(to filter: Filter) {
		self.dependency.filter = filter
	}
	
}

extension NoteUseCase: NoteManagable {
	
	public var list: [Note] {
		self.dependency.repository.list
	}
	
	public func add(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.add(item, completion: completion)
	}
	
	public func edit(newItem: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.edit(after: newItem, completion: completion)
	}
	
	public func delete(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}

}
