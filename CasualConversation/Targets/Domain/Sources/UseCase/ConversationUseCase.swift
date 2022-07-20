//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL


public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable { }

public protocol ConversationRecodable {
	func startRecording(completion: (Error?) -> Void)
	func pauseRecording()
	func stopRecording(completion: (Result<URL, Error>) -> Void)
//	func appendPin()
}

public protocol ConversationMaintainable {
	var list: [Conversation] { get }
	func add(item: Conversation, completion: (Error?) -> Void)
	func edit(newItem: Conversation, completion: (Error?) -> Void)
	func delete(item: Conversation, completion: (Error?) -> Void)
	func startPlaying(from selectedConversation: Conversation, completion: (Error?) -> Void)
	func stopPlaying()
	func pausePlaying()
}

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
	private var pinTemporaryStorage: [TimeInterval]?
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	private func createConversation(with filePath: URL) {
		let recordedDate = Date()
		let newItem: Conversation = .init(
			id: UUID(),
			title: recordedDate.description,
			members: [],
			recordFilePath: filePath,
			recordedDate: recordedDate,
			pins: self.pinTemporaryStorage ?? []
		)
		// TODO: 구현필요 - ConversationRepository
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
	
	public func stopRecording(completion: (Result<URL, Error>) -> Void) {
		self.dependency.audioService.stopRecording() { result in
			completion(result)
		}
	}
// TODO: 저장 위치 고민중
//	public func appendPin() {
//		if self.dependency.audioService.status == .playing,
//		   self.pinTemporaryStorage != nil {
//			let pinTime = self.dependency.audioService.currentRecordingTime
//			self.pinTemporaryStorage?.append(pinTime)
//		}
//	}
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public var list: [Conversation] {
		[] // TODO: 구현필요 - ConversationRepository
	}
	
	public func add(item: Conversation, completion: (Error?) -> Void) {
		// TODO: 구현필요 - ConversationRepository
	}
	
	public func edit(newItem: Conversation, completion: (Error?) -> Void) {
		// TODO: 구현필요 - ConversationRepository
	}
	
	public func delete(item: Conversation, completion: (Error?) -> Void) {
		// TODO: 구현필요 - ConversationRepository
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
