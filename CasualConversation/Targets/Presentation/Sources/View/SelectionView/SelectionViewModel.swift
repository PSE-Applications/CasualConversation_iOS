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
	@Published var members: String 
	@Published var recordedDate: String
	
	@Published var language: Language = .original
	@Published var category: Category = .sentense
	@Published var inputText: String = ""
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
		self.title = dependency.item.title ?? ""
		self.topic = dependency.item.topic ?? ""
		self.members = dependency.item.members.joined(separator: ", ")
		self.recordedDate = dependency.item.recordedDate.formattedString
	}
	
	var referenceNoteUseCase: NoteManagable {
		self.dependency.noteUseCase
	}
	var referenceItem: Conversation {
		self.dependency.item
	}
	
}

extension SelectionViewModel {
	
	var inputTextFieldPrompt: String {
		"\(self.language.description) \(self.category.description) 입력하세요"
	}
	
	var isAbleToAdd: Bool {
		checkConditions()
	}
	
	func editToggleLabel(by condition: Bool) -> String {
		condition ? "완료" : "수정"
	}
	
}

extension SelectionViewModel: LanguageCheckable {
	
	func addNote() {
		let newItem: Note = .init(
			id: .init(),
			original: language == .original ? self.inputText : "",
			translation: language == .translation ? self.inputText : "",
			category: category == .vocabulary ? .vocabulary : .sentence,
			references: [self.dependency.item.id],
			createdDate: Date()
		)
		self.dependency.noteUseCase.add(item: newItem) { error in
			guard error == nil else {
				CCError.log.append(.log("add Note 실패"))
				return
			}
			self.inputText = ""
		}
	}
	
	private func checkConditions() -> Bool {
		guard !inputText.isEmpty else { return false }
		guard checkLanguage() else { return false }
		guard checkCategory() else { return false }
		return true
	}
	
	private func checkLanguage() -> Bool {
		switch self.language {
		case .original:		return !containsKorean(by: self.inputText)
		case .translation:	return !containsEnglish(by: self.inputText)
		}
	}
	
	private func checkCategory() -> Bool {
		switch self.category {
		case .sentense:		return hasSpace(by: self.inputText, more: 2)
		case .vocabulary:	return !hasSpace(by: self.inputText, more: 2)
		}
	}
	
	func updateEditing(by newCondition: Bool) {
		if !newCondition {
			self.updateInfo()
		}
	}
	
	private func updateInfo() {
		let conversation = self.dependency.item
		let beforeInfo = (
			title: conversation.title,
			topic: conversation.topic,
			memebers: conversation.members
		)
		let afterInfo = (
			title: self.title.isEmpty ? conversation.recordedDate.formattedString : title,
			topic: self.topic,
			members: self.members
							.components(separatedBy: [",", " "] )
							.filter({ !$0.isEmpty })
		)
		if beforeInfo != afterInfo {
			let newItem: Conversation = .init(
				id: conversation.id,
				title: afterInfo.title,
				topic: afterInfo.topic,
				members: afterInfo.members,
				recordFilePath: conversation.recordFilePath,
				recordedDate: conversation.recordedDate,
				pins: conversation.pins)
			self.dependency.conversationUseCase.edit(after: newItem) { error in
				guard error == nil else {
					CCError.log.append(error!)
					return
				}
			}
		}
	}

}
