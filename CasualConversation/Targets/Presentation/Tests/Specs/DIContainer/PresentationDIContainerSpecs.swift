//
//  PresentationDIContainerSpecs.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/13.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Presentation

import Quick
import Nimble

extension PresentationDIContainer {
	static var sut: PresentationDIContainer {
		self.init(dependency: .init(
			conversationRepository: DebugConversationRepository(),
			noteRepository: DebugNoteRepository(),
			recordRepository: DebugRecordRepository())
		)
	}
}

final class PresentationDIContainerSpecs: QuickSpec {
	override func spec() {
		describe("인스턴스 객체") {
			var container: PresentationDIContainer!
			beforeEach { container = .sut }
			afterEach { container = nil }
			
			context("MainTabView 팩토리메서드 호출하면") {
				var mainTabView: MainTabView!
				beforeEach { mainTabView = container.MainTabView() }
				
				it("MainTabView 객체 생성됨") {
					expect(mainTabView).notTo(beNil())
				}
			}
			
			context("RecordView 팩토리메서드 호출하면") {
				var recordView: RecordView!
				beforeEach { recordView = container.RecordView() }
				
				it("RecordView 객체 생성됨") {
					expect(recordView).notTo(beNil())
				}
			}
			
			context("ConversationListView 팩토리메서드 호출하면") {
				var conversationListView: ConversationListView!
				beforeEach {
					conversationListView = container.ConversationListView()
				}
				
				it("RecordView 객체 생성됨") {
					expect(conversationListView).notTo(beNil())
				}
			}
			
			context("선택된 item을 전달하며 ConversationListRow 팩토리메서드 호출하면") {
				var listRow: ConversationListRow!
				beforeEach {
					listRow = container.ConversationListRow(selected: .empty)
				}
				
				it("ConversationListRow 객체 생성됨") {
					expect(listRow).notTo(beNil())
				}
			}
			
			context("선택된 item을 전달하며 SelectionView 팩토리메서드 호출하면") {
				var selectionView: SelectionView!
				beforeEach {
					selectionView = container.SelectionView(selected: .empty)
				}
				
				it("SelectionView 객체 생성됨") {
					expect(selectionView).notTo(beNil())
				}
			}
			
			context("NoteSetView 팩토리메서드 호출하면") {
				var recordView: NoteSetView!
				beforeEach { recordView = container.NoteSetView() }
				
				it("NoteSetView 객체 생성됨") {
					expect(recordView).notTo(beNil())
				}
			}
			
			context("사용할 NoteUseCase를 전달하며 NoteSetView 팩토리메서드 호출하면") {
				var recordView: NoteSetView!
				beforeEach {
					recordView = container.NoteSetView(by: container.noteUseCase)
				}
				
				it("NoteSetView 객체 생성됨") {
					expect(recordView).notTo(beNil())
				}
			}
			
			context("선택된 item을 전달하며 NoteSetRow 팩토리메서드 호출하면") {
				var noteSetRow: NoteSetRow!
				beforeEach {
					noteSetRow = container.NoteSetRow(by: .empty)
				}
				
				it("NoteSetRow 객체 생성됨") {
					expect(noteSetRow).notTo(beNil())
				}
			}
			
			context("SettingView 팩토리메서드 호출하면") {
				var settingView: SettingView!
				beforeEach { settingView = container.SettingView() }
				
				it("SettingView 객체 생성됨") {
					expect(settingView).notTo(beNil())
				}
			}
			
			context("service를 전달하며 PlayTabView 팩토리메서드 호출하면") {
				var playTabView: PlayTabView!
				beforeEach {
					playTabView = container.PlayTabView()
				}
				
				it("PlayTabView 객체 생성됨") {
					expect(playTabView).notTo(beNil())
				}
			}
			
			context("선택된 Note를 전달하며 NoteDetailView 팩토리메서드 호출하면") {
				var noteDetailView: NoteDetailView!
				beforeEach {
					noteDetailView = container.NoteDetailView(selected: .empty)
				}
				
				it("NoteDetailView 객체 생성됨") {
					expect(noteDetailView).notTo(beNil())
				}
			}
		}
	}
}
