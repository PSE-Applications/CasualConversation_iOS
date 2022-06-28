//
//  MainTabViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

final class MainTabViewModel: ObservableObject {
	
	struct Denpendency {
		let conversationUseCase: ConversationUseCaseManagable
		let noteUseCase: NoteUseCaseManagable
	}
	
	private let dependency: Denpendency
	
	init(dependency: Denpendency) {
		self.dependency = dependency
	}

}
