//
//  MockConversationDataController.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

struct MockConversationDataController {
	let `case`: Bool
	let error: CCError?
}

extension MockConversationDataController: ConversationDataControllerProtocol {
	
	func fetch() -> [Conversation]? {
		[]
	}
	
	func create(_ item: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func update(after editedItem: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
}

