//
//  MockConversationRepository.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Common
@testable import Domain

struct MockConversationRepository {
	let `case`: Bool
	let error: CCError?
}

extension MockConversationRepository: ConversationRepositoryProtocol {
	
	var list: [Conversation] {
		[]
	}
	
	func add(_ item: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func edit(after editedItem: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
	func delete(_ item: Conversation, completion: (CCError?) -> Void) {
		completion( `case` ? nil : error )
	}
	
}

