//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL
import Combine

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
	
//	@Published private var dataSource: [Conversation] = [] // 본 코드
	@Published private var dataSource: [Conversation] = [ // 테스트 코드
		.init(id: .init(), members: ["테스트 멤버1", "테스트 멤버2"], recordFilePath: Bundle.main.url(forResource: "Intro", withExtension: "mp3")!, recordedDate: Date(), pins: [3, 10, 17])
	]
	public var dataSourcePublisher: Published<[Conversation]>.Publisher { $dataSource }
	
	public init(dependency: Dependency) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		guard let fetcedList = dependency.dataController.fetch() else {
			print("Failure fetchDataSource") // TODO: Error 처리 고민필요
			return
		}
//		self.dataSource = fetcedList // 본 코드
		self.dataSource.append(contentsOf: fetcedList) // 테스트 코드
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
			fetchDataSource()
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
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
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
