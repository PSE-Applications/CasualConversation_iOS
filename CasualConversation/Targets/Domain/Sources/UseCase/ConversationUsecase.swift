//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation


public protocol ConversationRecodable {
	// TODO: Conversation C 기능
}

public protocol ConversationMaintainable {
	// TODO: Conversation RUD 기능
}

public protocol ConversationUseCaseManagable: ConversationRecodable, ConversationMaintainable  {
	
}

public final class ConversationUseCase: Dependency, ConversationUseCaseManagable {
	
	public struct Dependency {
		let repository: ConversationRepositoryProtocol
		
		public init(repository: ConversationRepositoryProtocol) {
			self.repository = repository
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}
