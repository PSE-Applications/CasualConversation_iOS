//
//  ConversationRepositoryProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

public protocol ConversationRepositoryProtocol {
	var list: [Conversation] { get }
	func add(_ item: Conversation, completion: (CCError?) -> Void)
	func edit(after editedItem: Conversation, completion: (CCError?) -> Void)
	func delete(_ item: Conversation, completion: (CCError?) -> Void)
}
