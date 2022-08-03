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
	
	public var id: Identifier
	public var title: String?
	public var topic: String?
	public var members: [String]
	public var recordFilePath: URL
	public var recordedDate: Date
	public var pins: [TimeInterval]
	
	public init(
		id: Identifier,
		title: String? = "",
		topic: String? = "",
		members: [String],
		recordFilePath: URL,
		recordedDate: Date,
		pins: [TimeInterval]
	) {
		self.id = id
		self.title = title
		self.topic = topic
		self.members = members
		self.recordFilePath = recordFilePath
		self.recordedDate = recordedDate
		self.pins = pins
	}
	
}
