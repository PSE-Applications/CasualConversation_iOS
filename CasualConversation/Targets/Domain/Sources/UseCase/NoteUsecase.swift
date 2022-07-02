//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

protocol NoteUseCaseManagable {
	// TODO: Conversation CRUD
}

final class NoteUseCase: NoteUseCaseManagable {
	
	struct Dependecy {
		let repository: NoteRepositoryProtocol
	}
	
	let dependency: Dependecy
	
	init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
}

