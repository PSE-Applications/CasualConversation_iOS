//
//  AppDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Data
import Presentation

import Foundation

final class AppDIContainer {
	
	private let configurations = AppConfigurations()
	
	// MARK: - Repository
	private lazy var coreDataStack: CoreDataStackProtocol = CoreDataStack()
	private lazy var fileManagerReposotiry: FileManagerRepositoryProtocol = FileManagerRepository()
	
	func makePresentationDIContainer() -> PresentationDIContainer {
		return .init(dependency: .init(
				configurations: PresentationConfiguarations(dependency:
					.init(
						mainURL: .init(string: configurations.mainURL)!,
						cafeURL: .init(string: configurations.cafeURL)!,
						eLearningURL: .init(string: configurations.eLearningURL)!,
						tasteURL: .init(string: configurations.tasteURL)!,
						testURL: .init(string: configurations.testURL)!,
						receptionTel: .init(string: configurations.receptionTel)!
					)),
				conversationRepository: ConversationRepository(dependency: .init(coreDataStack: self.coreDataStack)),
				noteRepository: NoteRepository(dependency: .init(coreDataStack: self.coreDataStack)),
				recordRepository: RecordRepository(dependency: .init(repository: self.fileManagerReposotiry))
			)
		)
	}
	
	func ContentView() -> ContentView {
		return .init()
	}
	
}
