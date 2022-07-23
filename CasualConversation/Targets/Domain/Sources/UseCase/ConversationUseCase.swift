//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL

public protocol ConversationRecodable {
	func startRecording(completion: (Error?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (Result<URL, Error>) -> Void)
	func createConversation(with filePath: URL)
}

public protocol ConversationMaintainable {
	func startPlaying(from selectedConversation: Conversation, completion: (Error?) -> Void)
	func stopPlaying()
	func pausePlaying()
}

public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable { }

public final class ConversationUseCase: Dependency, ConversationUseCaseManagable {
	
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
	
	private var conversations: [Conversation] = []
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
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
	
	public func stopRecording(completion: (Result<URL, Error>) -> Void) {
		self.dependency.audioService.stopRecording() { result in
			completion(result)
		}
	}

	public func createConversation(with filePath: URL) {
//		let newItem = Conversation(id: UUID(), title: <#T##String?#>, topic: <#T##String?#>, members: <#T##[Member]#>, recordFilePath: <#T##URL#>, recordedDate: <#T##Data#>)
		// TODO: Create Conversation
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
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
