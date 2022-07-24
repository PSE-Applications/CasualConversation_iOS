//
//  ConversationRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Domain

public struct ConversationRepository: ConversationRepositoryProtocol {
	
	public var list: [Conversation] = []
	
	public func add(_ item: Conversation, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func edit(newItem: Conversation, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Conversation, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
