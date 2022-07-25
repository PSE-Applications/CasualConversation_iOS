//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL


public protocol ConversationManagable: ConversationRecodable, ConversationMaintainable { }

public protocol ConversationRecodable {
	func startRecording(completion: (CCError?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (CCError?) -> Void)
}

public protocol ConversationMaintainable {
	var list: [Conversation] { get }
	func edit(newItem: Conversation, completion: (CCError?) -> Void)
	func delete(item: Conversation, completion: (CCError?) -> Void)
	func startPlaying(from selectedConversation: Conversation, completion: (CCError?) -> Void)
	func stopPlaying()
	func pausePlaying()
}

public final class ConversationUseCase: Dependency, ConversationManagable {
	
	public struct Dependency {
		let repository: ConversationRepositoryProtocol
		let audioService: AudioServiceProtocol
		
		public init(
			repository: ConversationRepositoryProtocol,
			recordService: AudioServiceProtocol
		) {
			self.repository = repository
			self.audioService = recordService
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	private func createConversation(with filePath: URL, completion: (CCError?) -> Void) {
		let recordedDate = Date()
		let newItem: Conversation = .init(
			id: UUID(),
			title: recordedDate.description,
			members: [],
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: []
		)
		self.dependency.repository.add(newItem, completion: completion)
	}
	
	public func startRecording(completion: (CCError?) -> Void) {
		self.dependency.audioService.setupRecorder() { error in
			guard error == nil else {
				completion(error)
				return
			}
		}
		self.dependency.audioService.startRecording() { error in
			guard error == nil else {
				completion(error)
				return
			}
		}
		completion(nil)
	}

	public func pauseRecording() {
		self.dependency.audioService.pauseRecording()
	}
	
	public func stopRecording(completion: (CCError?) -> Void) {
		self.dependency.audioService.stopRecording() { result in
			switch result {
			case .success(let savedfilePath):
				self.createConversation(with: savedfilePath, completion: completion)
			case .failure(let error):
				completion(error)
			}
		}
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public var list: [Conversation] {
		self.dependency.repository.list
	}
	
	public func edit(newItem: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.edit(after: newItem, completion: completion)
	}
	
	public func delete(item: Conversation, completion: (CCError?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}
	
	public func startPlaying(from selectedConversation: Conversation, completion: (CCError?) -> Void) {
		let filePath = selectedConversation.recordFilePath
		self.dependency.audioService.setupPlaying(from: filePath) { error in
			guard error == nil else {
				completion(error)
				return
			}
		}
		self.dependency.audioService.startPlaying() { error in
			guard error == nil else {
				completion(error)
				return
			}
		}
		completion(nil)
	}
	
	public func stopPlaying() {
		self.dependency.audioService.stopPlaying()
	}
	
	public func pausePlaying() {
		self.dependency.audioService.pauseRecording()
	}
	
}
