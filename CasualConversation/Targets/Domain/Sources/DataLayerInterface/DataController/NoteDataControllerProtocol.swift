//
//  NoteDataControllerProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

public protocol NoteDataControllerProtocol {
	func fetch(filter item: Conversation?) -> [Note]?
	func create(_ item: Note, completion: (CCError?) -> Void)
	func update(after updatedItem: Note, completion: (CCError?) -> Void)
	func delete(_ item: Note, completion: (CCError?) -> Void)
}
