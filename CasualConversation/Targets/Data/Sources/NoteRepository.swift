//
//  NoteRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

public struct NoteRepository: NoteRepositoryProtocol {
	
	public var list: [Note] = [] // TODO: 처리 필요
	
	public func add(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func edit(after editedItem: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
