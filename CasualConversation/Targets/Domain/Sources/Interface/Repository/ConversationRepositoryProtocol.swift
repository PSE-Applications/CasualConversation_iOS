//
//  ConversationRepositoryProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

public protocol ConversationRepositoryProtocol {
	var list: [Conversation] { get }
	func add(_ item: Conversation, completion: (Error?) -> Void)
	func edit(newItem: Conversation, completion: (Error?) -> Void)
	func delete(_ item: Conversation, completion: (Error?) -> Void)
}
