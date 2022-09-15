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
        let configurations: PresentationConfiguarations
		let conversationRepository: ConversationDataControllerProtocol
		let noteRepository: NoteDataControllerProtocol
		let recordRepository: RecordDataControllerProtocol
		
		public init(
            configurations: PresentationConfiguarations,
			conversationRepository: ConversationDataControllerProtocol,
			noteRepository: NoteDataControllerProtocol,
			recordRepository: RecordDataControllerProtocol
		) {
			self.configurations = configurations
			self.conversationRepository = conversationRepository
			self.noteRepository = noteRepository
			self.recordRepository = recordRepository
		}
	}
	
	public var dependency: Dependency
	
	// MARK: UseCase
	lazy var casualConversationUseCase: ConversationUseCase = .init(
		dependency: .init(
			dataController: self.dependency.conversationRepository
		)
	)
	lazy var noteUseCase: NoteUseCase = .init(dependency: .init(
		dataController: self.dependency.noteRepository,
		filter: .all)
	)
	
	// MARK: Service
	lazy var audioRecordService: AudioRecordService = .init(
		dependency: .init(
			dataController: self.dependency.recordRepository
		)
	)
	lazy var audioPlayService: AudioPlayService = .init(
		dependency: .init(
			dataController: self.dependency.recordRepository
		)
	)
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	private func makeNoteUseCase(filter item: Conversation) -> NoteUseCase {
		return .init(dependency: .init(
			dataController: self.dependency.noteRepository,
			filter: .selected(item))
		)
	}
	
}

extension PresentationDIContainer {
	
	var configurations: PresentationConfiguarations {
		self.dependency.configurations
	}
	
	func MainTabView() -> MainTabView {
		let viewModel: MainTabViewModel = .init()
		return .init(viewModel: viewModel)
	}
	
	func RecordView() -> RecordView {
		let viewModel: RecordViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioRecordService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListView() -> ConversationListView {
		let viewModel: ConversationListViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListRow(selected conversation: Conversation) -> ConversationListRow {
		let viewModel: ConversationListRowViewModel = .init(dependency: .init(
			item: conversation)
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
	
	func NoteSetRow(by note: Note) -> NoteSetRow {
		let viewModel: NoteSetRowViewModel = .init(dependency: .init(
			item: note)
		)
		return .init(viewModel: viewModel)
	}
	
	func SettingView() -> SettingView {
		let viewModel: SettingViewModel = .init()
		return .init(viewModel: viewModel)
	}
	
	func PlayTabView(with conversation: Conversation) -> PlayTabView {
		let viewModel: PlayTabViewModel = .init(dependency: .init(
				item: conversation,
				audioService: self.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteDetailView(selected note: Note) -> NoteDetailView {
		let viewModel: NoteDetailViewModel = .init(dependency: .init(
				useCase: self.noteUseCase,
				item: note
			)
		)
		return .init(viewModel: viewModel)
	}
	
}
