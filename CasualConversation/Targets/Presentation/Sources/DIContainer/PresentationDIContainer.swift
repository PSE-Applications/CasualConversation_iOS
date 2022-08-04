//
//  PresentationDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Combine

public final class PresentationDIContainer: Dependency, ObservableObject {
	
	public struct Dependency {
		let conversationRepository: ConversationRepositoryProtocol
		let noteRepository: NoteRepositoryProtocol
		let recordRepository: RecordRepositoryProtocol
		
		public init(
			conversationRepository: ConversationRepositoryProtocol,
			noteRepository: NoteRepositoryProtocol,
			recordRepository: RecordRepositoryProtocol
		) {
			self.conversationRepository = conversationRepository
			self.noteRepository = noteRepository
			self.recordRepository = recordRepository
		}
	}
	
	public var dependency: Dependency
	
	// MARK: UseCases
	lazy var casualConversationUseCase: ConversationUseCase = .init(
		dependency: .init(
			repository: self.dependency.conversationRepository
		)
	)
	lazy var noteUseCase: NoteUseCase = .init(
		dependency: .init(
			repository: self.dependency.noteRepository,
			filter: .all
		)
	)
	lazy var audioService: AudioService = .init(
		dependency: .init(
			repository: self.dependency.recordRepository
		)
	)
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	// MARK: View Factory
	enum Scene {
		case mainTab
		case record
		case selection
		case noteSet
	}
	
	public func MainTabView() -> MainTabView {
		let viewModel: MainTabViewModel = .init(dependency: .init())
		return .init(viewModel: viewModel)
	}
	
	func RecordView() -> RecordView {
		let viewModel: RecordViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func SelectionView(selected conversation: Conversation) -> SelectionView {
		self.noteUseCase.changeFilter(to: .selected(conversation))
		
		let viewModel: SelectionViewModel = .init(dependency: .init(
				conversationUseCase: self.casualConversationUseCase,
				noteUseCase: self.noteUseCase,
				audioService: self.audioService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteSetView() -> NoteSetView {
		self.noteUseCase.changeFilter(to: .all)
		
		let viewModel: NoteSetViewModel = .init(dependency: .init(
				useCase: self.noteUseCase
			)
		)
		return .init(viewModel: viewModel)
	}
	
}

// MARK: - Preview
#if DEBUG

import AVFAudio

extension AVAudioRecorder: AudioRecorderProtocol { }
extension AVAudioPlayer: AudioPlayerProtocol { }

struct DebugRecordRepository: RecordRepositoryProtocol {
	
	func makeAudioRecorder() -> AudioRecorderProtocol? {
		let recordSettings: [String: Any] = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100.0,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		let currentDate = Date().formatted(.dateTime)
		let newFilePath = FileManager.default.temporaryDirectory.appendingPathComponent(currentDate.description)
		let recorder = try? AVAudioRecorder(url: newFilePath, settings: recordSettings)
		return recorder
	}
	
	func makeAudioPlayer(from filePath: URL) -> AudioPlayerProtocol? {
		guard let player = try? AVAudioPlayer(contentsOf: filePath) else {
			return nil
		}
		return player
	}
	
}

struct DebugConversationRepository: ConversationRepositoryProtocol {
	var fetchList: [Conversation] {
		[]
	}
	
	func create(_ item: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func update(after updatedItem: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		print(#function)
	}
	
}

struct DebugNoteRepository: NoteRepositoryProtocol {
	var fetchList: [Note] {
		[]
	}
	
	func create(_ item: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func update(after updatedItem: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
	func delete(_ item: Note, completion: (CCError?) -> Void) {
		print(#function)
	}
	
}

extension PresentationDIContainer {
	
	static var preview: PresentationDIContainer {
		.init(dependency: .init(
			conversationRepository: DebugConversationRepository(),
			noteRepository: DebugNoteRepository(),
			recordRepository: DebugRecordRepository())
		)
	}
	
}
#endif
