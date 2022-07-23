//
//  Conversation.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/25.
//

import Foundation.NSURL
import Common

public struct Conversation: UUIDIdentifiable {
    
	public static var empty: Self {
		.init(
			id: UUID(),
			members: [],
			recordFilePath: URL(string: "Empty")!,
			recordedDate: Date(),
			pins: []
		)
	}
	
	public let id: Identifier
    var title: String?
    var topic: String?
    let members: [Member]
    let recordFilePath: URL
    let recordedDate: Date
	let pins: [TimeInterval]
	
}
