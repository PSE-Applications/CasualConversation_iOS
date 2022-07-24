//
//  NoteRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Domain

public struct NoteRepository: NoteRepositoryProtocol {
	
	public var list: [Note] = [] // TODO: 처리 필요
	
	public func add(item: Note, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func edit(newItem: Note, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(item: Note, completion: (Error?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
