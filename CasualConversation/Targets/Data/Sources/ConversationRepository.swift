//
//  ConversationRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

public struct ConversationRepository: ConversationRepositoryProtocol {
	
	public var fetchList: [Conversation] = [] // TODO: 처리 필요
	
	public func create(_ item: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func update(after editedItem: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
