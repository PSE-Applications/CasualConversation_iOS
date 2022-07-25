//
//  SelectionViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import Combine

public final class SelectionViewModel: Dependency, ObservableObject {
	
	public struct Dependency {
		let conversationUseCase: ConversationMaintainable
		let noteUseCase: NoteManagable
		
		public init(
			conversationUseCase: ConversationMaintainable,
			noteUseCase: NoteManagable
		) {
			self.conversationUseCase = conversationUseCase
			self.noteUseCase = noteUseCase
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}
