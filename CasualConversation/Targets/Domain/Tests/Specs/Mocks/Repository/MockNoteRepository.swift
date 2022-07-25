//
//  MockNoteRepository.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

struct MockNoteRepository {
	let `case`: Bool
	let error: CCError?
}

extension MockNoteRepository: NoteRepositoryProtocol {
	
	var list: [Note] {
		[]
	}
	
	func add(_ item: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func edit(after editedItem: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func delete(_ item: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
}

