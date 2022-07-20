//
//  MockConversationRepository.swift
//  DomainTests
//
//  Created by Yongwoo Marco on 2022/07/20.
//  Copyright © 2022 pseapplications. All rights reserved.
//

@testable import Domain

import Foundation
import AVFAudio

struct MockConversationRepository {
	let `case`: Bool
}

extension MockConversationRepository: ConversationRepositoryProtocol {
	
	var list: [Conversation] {
		[]
	}
	
	func add(_ item: Conversation, completion: (Error?) -> Void) {
		completion( `case` ? nil : (AnyObject.self as! Error) ) // TODO: Error 타입 변동필요
	}
	
	func edit(newItem: Conversation, completion: (Error?) -> Void) {
		completion( `case` ? nil : (AnyObject.self as! Error) ) // TODO: Error 타입 변동필요
	}
	
	func delete(_ item: Conversation, completion: (Error?) -> Void) {
		completion( `case` ? nil : (AnyObject.self as! Error) ) // TODO: Error 타입 변동필요
	}
	
}

