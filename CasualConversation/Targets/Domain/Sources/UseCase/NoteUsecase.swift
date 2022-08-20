//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

import Combine

public protocol NoteManagable {
	var dataSourcePublisher: Published<[Note]>.Publisher { get }
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
	
	@Published private var dataSource: [Note] = []
	public var dataSourcePublisher: Published<[Note]>.Publisher { $dataSource }
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		let fetcedList: [Note]
		switch dependency.filter {
		case .all:
			fetcedList = dependency.repository.fetch(filter: nil) ?? []
		case .selected(let item):
			fetcedList = dependency.repository.fetch(filter: item) ?? []
		}
		self.dataSource = fetcedList
	}
	
}

extension NoteUseCase: NoteManagable {
	
	public func add(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.create(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func edit(newItem: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.update(after: newItem) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func delete(item: Note, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}

}
