//
//  PresentationLayer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Presentation
@testable import Data // TODO: 외부 모듈 사용 없는 테스트 필요

import Quick
import Nimble

import Foundation

extension PresentationDIContainer {
	
	fileprivate static var testableDummy: PresentationDIContainer {
		self.init(dependency: .init(
			conversationRepository: ConversationRepository(),
			noteRepository: NoteRepository(),
			recordRepository: RecordRepository(dependency: .init(repository: FileManagerRepository()))))
	}
	
}

final class PresentationLayerSpecs: QuickSpec {
	override func spec() {
		
		describe("PresentationDIContainer 객체") {
			var presentationDIContainerSpecs: PresentationDIContainer!
			
			beforeEach {
				presentationDIContainerSpecs = .testableDummy
			}
			
			describe("새로운 View를 생성해주기 위해서") {
				context("MainTabView 팩토리메서드 호출하면") {
					var mainTabView: MainTabView!
					beforeEach { mainTabView = presentationDIContainerSpecs.MainTabView() }
					
					it("MainTabView 객체 생성됨") {
						expect(mainTabView).notTo(beNil())
					}
				}
				
				context("RecordView 팩토리메서드 호출하면") {
					var recordView: RecordView!
					beforeEach { recordView = presentationDIContainerSpecs.RecordView() }
					
					it("RecordView 객체 생성됨") {
						expect(recordView).notTo(beNil())
					}
				}
				
				context("선택된 Conversation을 전달하며 SelectionView 팩토리메서드 호출하면") {
					var selectionView: SelectionView!
					beforeEach { selectionView = presentationDIContainerSpecs.SelectionView(selected: .empty)
					}
					
					it("SelectionView 객체 생성됨") {
						expect(selectionView).notTo(beNil())
					}
				}
				
				context("NoteSetView 팩토리메서드 호출하면") {
					var recordView: NoteSetView!
					beforeEach { recordView = presentationDIContainerSpecs.NoteSetView() }
					
					it("MainTabView 객체 생성됨") {
						expect(recordView).notTo(beNil())
					}
				}
			}
		}
	}
}
