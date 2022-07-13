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
import SwiftUI

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
				
				it("call func MainTabView then MainTabView instance as some View") {
					// Arrange
					let mainTabView: MainTabView
					
					// Act
					mainTabView = presentationDIContainerSpecs.MainTabView()
					
					// Assert
					expect(mainTabView).notTo(beNil())
				}
				
				it("call func RecordView then RecordView instance as View") {
					// Arrange
					let recordView: RecordView
					
					// Act
					recordView = presentationDIContainerSpecs.RecordView()
					
					// Assert
					expect(recordView).notTo(beNil())
				}
				
				it("call func SelectionView then SelectionView instance as View") {
					// Arrange
					let testConversation = Conversation.dummy
					let selectionView: SelectionView
					
					// Act
					selectionView = presentationDIContainerSpecs.SelectionView(selected: testConversation)
					
					// Assert
					expect(selectionView).notTo(beNil())
				}
				
				it("call func NoteSetView then NoteSetView instance as View") {
					// Arrange
					let recordView: NoteSetView
					
					// Act
					recordView = presentationDIContainerSpecs.NoteSetView()
					
					// Assert
					expect(recordView).notTo(beNil())
				}
			}
		}
		
	}
	
}
