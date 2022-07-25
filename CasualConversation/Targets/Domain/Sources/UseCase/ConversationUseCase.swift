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
	func startRecording(completion: (Error?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (Error?) -> Void)
//	func appendPin()
}

public protocol ConversationMaintainable {
	var list: [Conversation] { get }
	func edit(newItem: Conversation, completion: (Error?) -> Void)
	func delete(item: Conversation, completion: (Error?) -> Void)
	func startPlaying(from selectedConversation: Conversation, completion: (Error?) -> Void)
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
	
	private func createConversation(with filePath: URL, completion: (Error?) -> Void) {
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
	
	public func startRecording(completion: (Error?) -> Void) {
		self.dependency.audioService.setupRecorder() { error in
			guard let error = error else {
				completion(nil)
				self.dependency.audioService.startRecording() { error in
					guard let error = error else {
						completion(nil)
						return
					}
					completion(error)
				}
				return
			}
			completion(error)
		}
	}

	public func pauseRecording() {
		self.dependency.audioService.pauseRecording()
	}
	
	public func stopRecording(completion: (Error?) -> Void) {
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
	
	public func edit(newItem: Conversation, completion: (Error?) -> Void) {
		self.dependency.repository.edit(newItem: newItem, completion: completion)
	}
	
	public func delete(item: Conversation, completion: (Error?) -> Void) {
		self.dependency.repository.delete(item, completion: completion)
	}
	
	public func startPlaying(from selectedConversation: Conversation, completion: (Error?) -> Void) {
		let filePath = selectedConversation.recordFilePath
		self.dependency.audioService.setupPlaying(from: filePath) { error in
			guard let error = error else {
				completion(nil)
				self.dependency.audioService.startPlaying() { error in
					guard let error = error else {
						completion(nil)
						return
					}
					completion(error)
				}
				return
			}
			completion(error)
		}
	}
	
	public func stopPlaying() {
		self.dependency.audioService.stopPlaying()
	}
	
	public func pausePlaying() {
		self.dependency.audioService.pauseRecording()
	}
	
}
