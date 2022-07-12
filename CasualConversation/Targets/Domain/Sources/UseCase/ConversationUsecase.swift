//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation


public protocol ConversationRecodable {
	func startRecording()
	func pauseRecording()
	func stopRecording(completion: (URL?) -> ())
	func createConversation(with filePath: URL)
}

public protocol ConversationMaintainable {
	func startPlayingAudio(from selectedConversation: Conversation)
	func stopPlayingAudio()
	func pausePlaying()
}

public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable  { }

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
	
	public func startRecording() {
		self.dependency.audioService.setupRecorder()
		self.dependency.audioService.startRecording()
	}

	public func pauseRecording() {
		self.dependency.audioService.pauseRecording()
	}
	
	public func stopRecording(completion: (URL?) -> Void) {
		let savedAudioFilePath = self.dependency.audioService.stopRecording()
		completion(savedAudioFilePath)
	}

	public func createConversation(with filePath: URL) {
//		let newItem = Conversation(id: UUID(), title: <#T##String?#>, topic: <#T##String?#>, members: <#T##[Member]#>, recordFilePath: <#T##URL#>, recordedDate: <#T##Data#>)
		// TODO: Create Conversation
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUseCase {
	
	public func startPlayingAudio(from selectedConversation: Conversation) {
		let filePath = selectedConversation.recordFilePath
		self.dependency.audioService.setupPlaying(from: filePath)
		self.dependency.audioService.playAudio()
	}
	
	public func stopPlayingAudio() {
		self.dependency.audioService.stopPlaying()
	}
	
	public func pausePlaying() {
		self.dependency.audioService.pauseRecording()
	}
	
}
