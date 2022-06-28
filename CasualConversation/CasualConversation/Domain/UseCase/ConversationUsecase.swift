//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Foundation

protocol ConversationRecodable {
	// TODO: Conversation C 기능
}

protocol ConversationManagable {
	// TODO: Conversation RUD 기능
}

final class ConversationUseCase: ConversationRecodable, ConversationManagable {
	
	struct Dependecy {
		let repository: ConversationRepositoryProtocol
	}
	
	let dependency: Dependecy
	
	init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
}
