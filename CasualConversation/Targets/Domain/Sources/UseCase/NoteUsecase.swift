//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

public protocol NoteUseCaseManagable {
	var list: [Note] { get }
	func add(item: Note, completion: (Error?) -> Void)
	func edit(newItem: Note, completion: (Error?) -> Void)
	func delete(item: Note, completion: (Error?) -> Void)
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

extension NoteUseCase: NoteUseCaseManagable {
	
	public var list: [Note] {
		self.dependency.repository.list
	}
	
	public func add(item: Note, completion: (Error?) -> Void) {
		self.dependency.repository.add(item: item, completion: completion)
	}
	
	public func edit(newItem: Note, completion: (Error?) -> Void) {
		self.dependency.repository.edit(newItem: newItem, completion: completion)
	}
	
	public func delete(item: Note, completion: (Error?) -> Void) {
		self.dependency.repository.delete(item: item, completion: completion)
	}

}
