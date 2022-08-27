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
	func edit(_ newItem: Note, completion: (CCError?) -> Void)
	func delete(item: Note, completion: (CCError?) -> Void)
}

public final class NoteUseCase: Dependency {
	
	public enum Filter {
		case all
		case selected(Conversation)
	}
	
	public struct Dependecy {
		let dataController: NoteDataControllerProtocol
		var filter: Filter
		
		public init(
			dataController: NoteDataControllerProtocol,
			filter: Filter
		) {
			self.dataController = dataController
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
			fetcedList = dependency.dataController.fetch(filter: nil) ?? []
		case .selected(let item):
			fetcedList = dependency.dataController.fetch(filter: item) ?? []
		}
		self.dataSource = fetcedList.filter({ !$0.isDone }) + fetcedList.filter({ $0.isDone })
	}
	
}

extension NoteUseCase: NoteManagable {
	
	public func add(item: Note, completion: (CCError?) -> Void) {
		self.dependency.dataController.create(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func edit(_ newItem: Note, completion: (CCError?) -> Void) {
		self.dependency.dataController.update(after: newItem) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func delete(item: Note, completion: (CCError?) -> Void) {
		self.dependency.dataController.delete(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}

}
