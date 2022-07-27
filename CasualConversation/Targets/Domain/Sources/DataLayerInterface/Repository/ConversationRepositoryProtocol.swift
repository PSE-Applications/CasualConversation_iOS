//
//  ConversationRepositoryProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

public protocol ConversationRepositoryProtocol {
	var fetchList: [Conversation] { get }
	func create(_ item: Conversation, completion: (CCError?) -> Void)
	func update(after updatedItem: Conversation, completion: (CCError?) -> Void)
	func delete(_ item: Conversation, completion: (CCError?) -> Void)
}
