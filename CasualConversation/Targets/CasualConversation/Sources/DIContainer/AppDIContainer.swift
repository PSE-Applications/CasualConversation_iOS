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
            configurations: .init(dependency: .init(
                mainURL: URL(string: configurations.mainURL)!,
                cafeURL: URL(string: configurations.cafeURL)!,
                eLearningURL: URL(string: configurations.eLearningURL)!,
                tasteURL: URL(string: configurations.tasteURL)!,
                testURL: URL(string: configurations.testURL)!,
                receptionTel: URL(string: configurations.receptionTel)!
            )
            ),
            conversationRepository: ConversationDataController(dependency: .init(coreDataStack: self.coreDataStack)),
            noteRepository: NoteDataController(dependency: .init(coreDataStack: self.coreDataStack)),
            recordRepository: RecordDataController(dependency: .init(repository: self.fileManagerReposotiry))
        )
        )
    }
    
    func ContentView() -> ContentView {
        return .init()
    }
    
}
