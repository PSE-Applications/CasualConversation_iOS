//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Foundation

public protocol ConversationRecodable {
	// TODO: Conversation C 기능
}

public protocol ConversationMaintainable {
	// TODO: Conversation RUD 기능
}

public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable  {
	
}

public final class ConversationUseCase: ConversationUseCaseManagable {
	
	struct Dependecy {
		let repository: ConversationRepositoryProtocol
	}
	
	let dependency: Dependecy
	
	init(dependency: Dependecy) {
		self.dependency = dependency
	}
	
}
