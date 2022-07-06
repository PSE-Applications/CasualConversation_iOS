//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation


public protocol ConversationRecodable {
	// TODO: Conversation C 기능
	func setupRecorder()
	func startRecording()
	func stopRecording()
}

public protocol ConversationMaintainable {
	// TODO: Conversation RUD 기능
}

public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable  {
	
}

public final class ConversationUseCase: Dependency, ConversationUseCaseManagable {
	
	public struct Dependency {
		let repository: ConversationRepositoryProtocol
		let recordService: RecordServiceProtocol
		
		public init(
			repository: ConversationRepositoryProtocol,
			recordService: RecordServiceProtocol
		) {
			self.repository = repository
			self.recordService = recordService
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	private func createConversation(with filePath: URL) {
		
	}

}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
	public func setupRecorder() {
		self.dependency.recordService.setupRecorder()
	}
	
	public func startRecording() {
		self.dependency.recordService.startRecording()
	}

	public func stopRecording() {
		self.dependency.recordService.stopRecording()
		
		// 저장된 filePath 받아오기
		// let savedAudioFilePath: URL = ...
		// createConversation(with: savedAudioFilePath)
	}

}
