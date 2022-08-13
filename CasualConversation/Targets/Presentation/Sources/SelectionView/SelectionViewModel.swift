//
//  SelectionViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import SwiftUI
import Foundation

final class SelectionViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let conversationUseCase: ConversationMaintainable
		let noteUseCase: NoteManagable
		let item: Conversation
	}
	
	let dependency: Dependency
	
	@Published var title: String
	@Published var topic: String
	@Published var members: String // TODO: 저장 시 (콤마, 공백) 제거처리
	
	@Published var isVocabulary: Bool = true
	@Published var isOriginal: Bool = true
	@Published var inputText: String = ""
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.title = dependency.item.title ?? ""
		self.topic = dependency.item.topic ?? ""
		self.members = dependency.item.members.joined(separator: ", ")
	}
	
	var referenceNoteUseCase: NoteManagable {
		self.dependency.noteUseCase
	}
	
}

extension SelectionViewModel {
	
	var isOriginalSwitchLabel: String {
		self.isOriginal ? "영어" : "한글"
	}
	var isOriginalSwitchImageName: String {
		self.isOriginal ? "e.circle.fill" : "k.circle.fill"
	}
	var isVocabularySwitchLabel: String {
		self.isVocabulary ? "문장" : "단어"
	}
	var isVocabularySwitchImageName: String {
		self.isVocabulary ? "text.bubble.fill" : "textformat.abc"
	}
	var inputTextFieldPrompt: String {
		"\(self.isOriginalSwitchLabel) \(self.isVocabularySwitchLabel) 입력하세요"
	}
	
	func editToggleLabel(by condition: Bool) -> String {
		condition ? "완료" : "수정"
	}
	func isEditingShadowColor(by condition: Bool) -> Color {
		condition ? .clear : .gray
	}
	
}

extension SelectionViewModel {
	
	var list: [Note] { // TODO: DataBinding 형태로 변경 필요
		self.dependency.noteUseCase.list()
	}

}
