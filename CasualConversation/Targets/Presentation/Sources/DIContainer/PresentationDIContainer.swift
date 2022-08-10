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
	lazy var noteUseCase: NoteUseCase = .init(dependency: .init(
		repository: self.dependency.noteRepository,
		filter: .all)
	)
	lazy var audioService: AudioService = .init(
		dependency: .init(
			repository: self.dependency.recordRepository
		)
	)
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	private func makeNoteUseCase(filter item: Conversation) -> NoteUseCase {
		return .init(dependency: .init(
			repository: self.dependency.noteRepository,
			filter: .selected(item))
		)
	}
	
}

extension PresentationDIContainer {
	
	func MainTabView() -> MainTabView {
		return .init()
	}
	
	func RecordView() -> RecordView {
		let viewModel: RecordViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListView() -> ConversationListView {
		let viewModel: ConversationListViewModel = .init(dependency: .init(
			useCase: self.casualConversationUseCase)
		)
		return .init(viewModel: viewModel)
	}
	
	func SelectionView(selected conversation: Conversation) -> SelectionView {
		let viewModel: SelectionViewModel = .init(dependency: .init(
				conversationUseCase: self.casualConversationUseCase,
				noteUseCase: makeNoteUseCase(filter: conversation),
				item: conversation
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteSetView(by usecase: NoteManagable? = nil) -> NoteSetView {
		let viewModel: NoteSetViewModel
		if let bindedUseCase = usecase {
			viewModel = .init(dependency: .init(useCase: bindedUseCase))
		} else {
			viewModel = .init(dependency: .init(useCase: self.noteUseCase))
		}
		return .init(viewModel: viewModel)
	}
	
	func SettingView() -> SettingView {
		return .init()
	}
	
	func PlayTabView() -> PlayTabView {
		let viewModel: PlayTabViewModel = .init(dependency: .init(
				audioService: self.audioService
			)
		)
		return .init(viewModel: viewModel)
	}
	
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
	
	private var dummyModel: [Conversation] = [
		.init(
			id: .init(),
			title: Date().formattedString,
			members: [],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(),
			pins: []
		),
		.init(
			id: .init(),
			title: "지하철 외국인",
			topic: "인사",
			members: ["나", "외국인"],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 100.0),
			pins: []),
		.init(
			id: .init(),
			title: "with Date",
			topic: "Weather",
			members: ["Me, Dale"],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 200.0),
			pins: []),
		.init(
			id: .init(),
			title: Date(timeIntervalSinceNow: 250).formattedString,
			members: [],
			recordFilePath: .init(fileURLWithPath: ""),
			recordedDate: Date(timeIntervalSinceNow: 250),
			pins: []
		)
	]
	
	func fetch() -> [Conversation]? {
		dummyModel
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
	
	private var dummyModel: [Note] = [
		.init(
			id: .init(),
			original: "컴퓨터",
			translation: "",
			category: .vocabulary,
			references: [],
			createdDate: Date()),
		.init(
			id: .init(),
			original: "",
			translation: "Conversation",
			category: .vocabulary,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 200)),
		.init(
			id: .init(),
			original: "This is a sentence",
			translation: "이거슨 문장입니다.",
			category: .sentece,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 150)),
		.init(
			id: .init(),
			original: "",
			translation: "하고 싶었던 한국말 문장을 저장해 놈",
			category: .sentece,
			references: [],
			createdDate: Date()),
		.init(
			id: .init(),
			original: "Complete",
			translation: "완성하다",
			category: .vocabulary,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 100)),
		.init(
			id: .init(),
			original: "These are sentences\nThey have sevaral lines.\nlike this",
			translation: "",
			category: .sentece,
			references: [],
			createdDate: Date(timeIntervalSinceNow: 50))
	]
	
	func fetch(filter item: Conversation?) -> [Note]? {
		if let _ = item {
			return dummyModel.enumerated().filter { $0.offset % 2 == Int.random(in: 0...1) }.map { $0.element }
		} else {
			return dummyModel
		}
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
