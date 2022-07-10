//
//  SelectionViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import Foundation

public final class SelectionViewModel: Dependency, ObservableObject {
	
	public struct Dependency {
		let conversationUseCase: ConversationMaintainable
		let noteUseCase: NoteUseCaseManagable
		
		public init(
			conversationUseCase: ConversationMaintainable,
			noteUseCase: NoteUseCaseManagable
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
