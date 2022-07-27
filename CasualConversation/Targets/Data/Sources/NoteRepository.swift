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
	
	public var fetchList: [Note] = [] // TODO: 처리 필요
	
	public func create(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func update(after editedItem: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public func delete(_ item: Note, completion: (CCError?) -> Void) {
		// TODO: 처리 필요
	}
	
	public init() {}
	
}
