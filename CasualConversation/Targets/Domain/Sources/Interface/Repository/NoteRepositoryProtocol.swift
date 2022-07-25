//
//  NoteRepositoryProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

public protocol NoteRepositoryProtocol {
	var list: [Note] { get }
	func add(_ item: Note, completion: (CCError?) -> Void)
	func edit(after editedItem: Note, completion: (CCError?) -> Void)
	func delete(_ item: Note, completion: (CCError?) -> Void)
}
