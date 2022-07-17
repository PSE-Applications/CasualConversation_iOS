//
//  PresentationDIContainerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Presentation
@testable import Data
@testable import Domain

import Quick
import Nimble

import Foundation

extension Conversation {
	
	static let dummy: Conversation = .init(
		id: UUID(), members: [], recordFilePath: URL(string: "dummy")!, recordedDate: Date()
	)
	
}

final class PresentationDIContainerSpecs: QuickSpec {
	
	override func spec() {
		
		var presentationDIContainerSpecs: PresentationDIContainer!
		
		beforeEach {
			presentationDIContainerSpecs = PresentationDIContainer(dependency: .init(
				conversationRepository: ConversationRepository(),
				noteRepository: NoteRepository(),
				recordRepository: RecordRepository(dependency: .init(
							repository: FileManagerRepository()
						)
					)
				)
			)
		}
		
		describe("as PresentationDIContainer") {
			
			context("FactoryMethods") {
				
				it("call func MainTabView then MainTabView instance") {
					let mainTabView: MainTabView
					
					mainTabView = presentationDIContainerSpecs.MainTabView()
					
					expect(mainTabView).notTo(beNil())
				}
				
				it("call func RecordView then RecordView instance") {
					let recordView: RecordView
					
					recordView = presentationDIContainerSpecs.RecordView()
					
					expect(recordView).notTo(beNil())
				}
				
				it("call func SelectionView then SelectionView instance") {
					let testConversation = Conversation.dummy
					let selectionView: SelectionView
					
					selectionView = presentationDIContainerSpecs.SelectionView(selected: testConversation)
					
					expect(selectionView).notTo(beNil())
				}
				
				it("call func NoteSetView then NoteSetView instance") {
					let recordView: NoteSetView
					
					recordView = presentationDIContainerSpecs.NoteSetView()
					
					expect(recordView).notTo(beNil())
				}
			}
		}
	}
	
}
