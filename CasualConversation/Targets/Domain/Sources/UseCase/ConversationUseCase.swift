//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Combine
import Foundation

public protocol ConversationManagable: ConversationRecodable, ConversationMaintainable { }

public protocol ConversationRecodable {
	func add(_ item: Conversation, completion: (CCError?) -> Void)
}

public protocol ConversationMaintainable {
	var dataSourcePublisher: Published<[Conversation]>.Publisher { get }
	func edit(after editedItem: Conversation, completion: (CCError?) -> Void)
	func delete(_ item: Conversation, completion: (CCError?) -> Void)
}

public final class ConversationUseCase: Dependency, ConversationManagable {
	
	public struct Dependency {
		let dataController: ConversationDataControllerProtocol
		
		public init(dataController: ConversationDataControllerProtocol) {
			self.dataController = dataController
		}
	}
	
	public let dependency: Dependency
	public var dataSourcePublisher: Published<[Conversation]>.Publisher { $dataSource }
	
	public init(dependency: Dependency) {
		self.dependency = dependency
		
		NotificationCenter.default.publisher(for: .updatedConversation)
			.sink { [weak self] _ in
				self?.fetchDataSource()
			}
			.store(in: &cancellableSet)
		
//		fetchDataSource()
		NotificationCenter.default.post(name: .updatedConversation, object: nil)
	}
	
	@Published private var dataSource: [Conversation] = []
	private var cancellableSet: Set<AnyCancellable> = []
	
	private func fetchDataSource() {
		guard let fetcedList = dependency.dataController.fetch() else {
			CCError.log.append(.log("Failure fetchDataSource"))
			return
		}
		self.dataSource = fetcedList
	}
 
}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	public func add(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.dataController.create(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			NotificationCenter.default.post(name: .updatedNote, object: nil)
			completion(nil)
		}
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public func edit(after editedItem: Conversation, completion: (CCError?) -> Void) {
		self.dependency.dataController.update(after: editedItem) { error in
			guard error == nil else {
				completion(error)
				return
			}
			NotificationCenter.default.post(name: .updatedNote, object: nil)
			completion(nil)
		}
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.dataController.delete(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			NotificationCenter.default.post(name: .updatedNote, object: nil)
			completion(nil)
		}
	}
	
}
