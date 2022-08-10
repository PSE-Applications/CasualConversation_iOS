//
//  SelectionViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import SwiftUI

final class SelectionViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let conversationUseCase: ConversationMaintainable
		let noteUseCase: NoteManagable
		let audioService: AudioService
	}
	
	let dependency: Dependency
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}

}

extension SelectionViewModel {
	
	var list: [Note] { // TODO: DataBinding 형태로 변경 필요
		self.dependency.noteUseCase.list()
	}
	
	var referenceNoteUseCase: NoteManagable {
		self.dependency.noteUseCase
	}
	
}
