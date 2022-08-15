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
	
	enum Language: CaseIterable, CustomStringConvertible {
		case original
		case translation
		
		var description: String {
			switch self {
			case .original:		return "영어"
			case .translation:	return "한글"
			}
		}
	}
	
	enum Category: CaseIterable, CustomStringConvertible {
		case sentense
		case vocabulary
		
		var description: String {
			switch self {
			case .sentense:			return "문장"
			case .vocabulary:		return "단어"
			}
		}
	}
	
	struct Dependency {
		let conversationUseCase: ConversationMaintainable
		let noteUseCase: NoteManagable
		let item: Conversation
	}
	
	let dependency: Dependency
	
	@Published var title: String
	@Published var topic: String
	@Published var members: String // TODO: 저장 시 (콤마, 공백) 제거처리
	@Published var recordedDate: String
	
	@Published var language: Language = .original
	@Published var category: Category = .sentense
	@Published var inputText: String = ""
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.title = dependency.item.title ?? ""
		self.topic = dependency.item.topic ?? ""
		self.members = dependency.item.members.joined(separator: ", ")
		self.recordedDate = dependency.item.recordedDate.description
	}
	
	var referenceNoteUseCase: NoteManagable {
		self.dependency.noteUseCase
	}
	
}

extension SelectionViewModel {
	
	var inputTextFieldPrompt: String {
		"\(self.language.description) \(self.category.description) 입력하세요"
	}
	
	func editToggleLabel(by condition: Bool) -> String {
		condition ? "완료" : "수정"
	}
	
	func isEditingShadowColor(by condition: Bool) -> Color {
		condition ? .clear : .gray
	}
	
	func setEmptyTitleToDefault(by newValue: Bool) {
		if !newValue, self.title.isEmpty {
			self.title = self.recordedDate
		} 
	}
	
}

extension SelectionViewModel {
	
	var list: [Note] { // TODO: DataBinding 형태로 변경 필요
		self.dependency.noteUseCase.list()
	}

}
