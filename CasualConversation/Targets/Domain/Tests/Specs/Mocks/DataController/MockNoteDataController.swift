//
//  MockNoteDataController.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

struct MockNoteDataController {
	let `case`: Bool
	let error: CCError?
}

extension MockNoteDataController: NoteDataControllerProtocol {
	
	func fetch(filter item: Conversation?) -> [Note]? {
		[]
	}
	
	func create(_ item: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func update(after editedItem: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func delete(_ item: Note, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
}

