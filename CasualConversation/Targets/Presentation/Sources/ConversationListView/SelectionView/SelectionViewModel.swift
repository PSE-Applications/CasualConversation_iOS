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
		let audioPlayService: CCPlayer
		
		public init(
			conversationUseCase: ConversationMaintainable,
			noteUseCase: NoteManagable,
			audioPlayService: CCPlayer
		) {
			self.conversationUseCase = conversationUseCase
			self.noteUseCase = noteUseCase
			self.audioPlayService = audioPlayService
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}

}
