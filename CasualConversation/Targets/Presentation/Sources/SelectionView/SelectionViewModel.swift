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
	
	var list: [Note] { // TODO: DataBinding 형태로 변경 필요
		self.dependency.noteUseCase.list()
	}

}
