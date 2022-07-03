//
//  NoteUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Foundation

public protocol NoteUseCaseManagable {
	// TODO: Conversation CRUD
}

public final class NoteUseCase: NoteUseCaseManagable {
	
	struct Dependecy {
		let repository: NoteRepositoryProtocol
	}
	
	let dependency: Dependecy
	
	init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
}

