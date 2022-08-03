//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

public protocol NoteManagable {
	func list() -> [Note]
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
	
	private var dataSource: [Note] = []
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
	private func fetchDataSource() {
		switch dependency.filter {
		case .all:
			guard let list = dependency.repository.fetch(filter: nil) else {
				return
			}
			self.dataSource = list
		case .selected(let item):
			guard let list = dependency.repository.fetch(filter: item) else {
				return
			}
			self.dataSource = list
		}
		
	}
	
}

extension NoteUseCase: NoteManagable {
	
	public func list() -> [Note] {
		self.dataSource
	}
	
	public func add(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.create(item, completion: completion)
	}
	
	public func edit(newItem: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.update(after: newItem, completion: completion)
	}
	
	public func delete(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}

}
