//
//  NoteRepositoryProtocol.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

public protocol NoteRepositoryProtocol {
	var list: [Note] { get }
	func add(item: Note, completion: (Error?) -> Void)
	func edit(newItem: Note, completion: (Error?) -> Void)
	func delete(item: Note, completion: (Error?) -> Void)
}
