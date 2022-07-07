//
//  AppDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Data
import Domain
import Presentation

import Foundation

final class AppDIContainer {
	
	lazy var appConfigurations = AppConfigurations()
	
	// MARK: - Repository
	lazy var conversationRepository: ConversationRepositoryProtocol = ConversationRepository()
	lazy var noteRepository: NoteRepositoryProtocol = NoteRepository()
	lazy var audioRepository: RecordRepositoryProtocol = AudioRepository()
	
	func makePresentationDIContainer() -> PresentationDIContainer {
		return .init(
			dependency: .init(
				conversationRepository: self.conversationRepository,
				noteRepository: self.noteRepository,
				audioRepository: self.audioRepository
			)
		)
	}
	
	func PresentationEntryPoint() -> MainTabView {
		let viewModel: MainTabViewModel = .init(dependency: .init())
		return .init(viewModel: viewModel)
	}
	
}
